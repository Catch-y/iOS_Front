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
    var cancellables = Set<AnyCancellable>()
    
    @Published var avatars: [(image: String, status: Bool)] = [] // status는 항상 false로 처리
    @Published var voteResponse: VoteResponse?
    @Published var isVoteMemberLoading: Bool = false
    @Published var errorMessage: String? = nil // 에러 메시지 처리
    
    // MARK: - Initializer
    init(container: DIContainer) {
        self.container = container
    }
    
    // MARK: - 샘플 데이터 로드 함수
    func loadSampleData() {
        let sampleTarget = VotingMemberAPITarget.getVoteMember(vote: VoteRequest(groupId: 1, voteId: 1))
        do {
            let response = try JSONDecoder().decode(ResponseData<VoteResponse>.self, from: sampleTarget.sampleData)
            DispatchQueue.main.async {
                if let members = response.result?.members {
                    self.avatars = members.map { member in
                        return (image: member.profileImage, status: false) // 항상 false로 처리
                    }
                }
                print("✅ 샘플 데이터 로드 성공: \(response)")
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "샘플 데이터를 로드할 수 없습니다: \(error.localizedDescription)"
                print("❌ 샘플 데이터 디코딩 실패: \(error)")
            }
        }
    }
    
    // MARK: - API 호출 함수
    func getVoteMember(voteRequest: VoteRequest) {
        isVoteMemberLoading = true
        errorMessage = nil // 에러 메시지 초기화
        
        container.useCaseProvider.votingMemberUseCase
            .executeGetVoteMember(voteRequest: voteRequest)
            .tryMap { responseData -> ResponseData<VoteResponse> in
                if !responseData.isSuccess {
                    throw APIError.serverError(
                        message: responseData.message,
                        code: responseData.code
                    )
                }
                return responseData
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
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let result = response.result {
                    self.voteResponse = result
                    self.avatars = result.members.map { member in
                        return (image: member.profileImage, status: false) // 항상 hasVoted를 false로 처리
                    }
                    
                    print("✅ Get VoteMember 성공: \(result)")
                }
            })
            .store(in: &cancellables)
    }
}
