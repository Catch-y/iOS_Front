//
//  VoteBeforeMemberViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/6/25.
//

import Foundation
import SwiftUI
import Combine

class GroupVoteBeforeMemberViewModel: ObservableObject {
    
    // MARK: - Properties
    let container: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    @Published var avatars: [(image: String, status: Bool)] = [] //  `status` 항상 false로 설정
    @Published var isVoteMemberLoading: Bool = false
    @Published var errorMessage: String? = nil // 에러 메시지 처리
    
    // MARK: - Initializer
    init(container: DIContainer) {
        self.container = container
    }
    
    // MARK: - 샘플 데이터 로드 함수
    private func loadSampleData() {
        guard let sampleResponse = try? JSONDecoder().decode(
            BaseResponseVoteMemberListResponse.self, // `BaseResponseVoteMemberListResponse` 사용
            from: VoteAPITarget.getVoteMembers(groupId: 1, voteId: 1).sampleData
        ) else {
            DispatchQueue.main.async {
                self.errorMessage = "샘플 데이터 디코딩 실패"
                print("❌ 샘플 데이터 디코딩 실패")
            }
            return
        }
        
        DispatchQueue.main.async {
            self.avatars = sampleResponse.result.map { member in
                return (image: member.profileImage, status: false) // ✅ 항상 false
            }
            print("샘플 데이터 로드 성공 (모두 false)")
        }
    }
    
    // MARK: - API 호출 함수
    func getVoteMembers(groupId: Int, voteId: Int) {
        isVoteMemberLoading = true
        errorMessage = nil // 에러 메시지 초기화
        
        container.useCaseProvider.voteUseCase
            .executeGetVoteMembers(groupId: groupId, voteId: voteId)
            .tryMap { responseData -> [VoteMemberResponse] in  //  `VoteMemberResponse` 리스트로 반환
                guard responseData.isSuccess else {
                    throw APIError.serverError(
                        message: responseData.message,
                        code: responseData.code
                    )
                }
                return responseData.result ?? []
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isVoteMemberLoading = false // 로딩 상태 종료
                
                switch completion {
                case .finished:
                    print("투표 전 멤버 View 연동 성공")
                case .failure(let failure):
                    self.errorMessage = "데이터를 로드하는 중 오류가 발생했습니다: \(failure.localizedDescription)"
                    print("❌ Get VoteMember Failed: \(failure)")
                    self.loadSampleData() // API 실패 시 샘플 데이터 활용
                }
            }, receiveValue: { [weak self] members in
                guard let self = self else { return }
                
                self.avatars = members.map { member in
                    return (image: member.profileImage, status: false) // ✅ 항상 false로 설정
                }
                
                print("Get VoteMember 성공: 총 \(members.count)명 (모두 false)")
            })
            .store(in: &cancellables)
    }
}
