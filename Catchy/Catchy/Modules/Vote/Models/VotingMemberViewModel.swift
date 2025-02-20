//
//  GroupVoteStartViewModel.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import SwiftUI
import Combine
import Moya

class VotingMemberViewModel: ObservableObject {
    
    // MARK: - Properties
    let container: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    @Published var avatars: [(image: String, status: Bool)] = [] {
        didSet {
            checkVoteCompletion() // 아바타 상태변경체크
        }
    }
    @Published var isVoteMemberLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isVoteComplete: Bool = false

    let provider = MoyaProvider<VoteAPITarget>(stubClosure: MoyaProvider.immediatelyStub) // 샘플 데이터 사용
    
    // MARK: - Initializer
    init(container: DIContainer) {
        self.container = container
    }
    
    // MARK: - API 호출 함수
    func getVoteMembers(groupId: Int, voteId: Int) {
        isVoteMemberLoading = true
        errorMessage = nil

        provider.request(.getVoteMembers(groupId: groupId, voteId: voteId)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(BaseResponseVoteMemberListResponse.self, from: response.data)
                    
                    DispatchQueue.main.async {
                        self.isVoteMemberLoading = false

                        if decodedData.isSuccess {
                            self.avatars = decodedData.result.map { member in
                                    return (image: member.profileImage, status: member.hasVoted)
                                }
                            self.checkVoteCompletion() // 모든 멤버가 투표했는지 확인
                        } else {
                            self.errorMessage = decodedData.message
                            self.loadSampleData() // 샘플 데이터 로드
                        }
                    }
                } catch {
                    print("[오류] JSON 디코딩 실패: \(error)")
                    self.loadSampleData()
                }
            case .failure(let error):
                print("[오류] API 요청 실패: \(error.localizedDescription)")
                self.loadSampleData()
            }
        }
    }
    
    // MARK: - 샘플 데이터 로드 함수
    func loadSampleData() {
        guard let sampleResponse = try? JSONDecoder().decode(
            BaseResponseVoteMemberListResponse.self,
            from: VoteAPITarget.getVoteMembers(groupId: 1, voteId: 1).sampleData
        ) else {
            DispatchQueue.main.async {
                self.errorMessage = "샘플 데이터 디코딩 실패"
                print("[오류] 샘플 데이터 디코딩 실패")
            }
            return
        }

        DispatchQueue.main.async {
            self.avatars = sampleResponse.result.map { member in
                return (image: member.profileImage, status: member.hasVoted)
            }
            print("샘플 데이터 로드 성공")
        }
    }
    // MARK: - 모든 멤버가 투표했는지 확인하는 함수
    private func checkVoteCompletion() {
        if avatars.allSatisfy({ $0.status }) { //  모든 멤버가 `status = true`이면
            isVoteComplete = true
            DispatchQueue.main.async {
                self.isVoteComplete = true
               
            }
        }
    }

}
