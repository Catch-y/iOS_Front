//
//  GroupVoteStartViewModel.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import SwiftUI
import Combine

class VotingMemberViewModel: ObservableObject {
    
    // MARK: - Properties
    let container: DIContainer
    var cancellables = Set<AnyCancellable>()
    
    @Published var avatars: [(image: String, status: Bool)] = []
    @Published var voteResponse: VoteResponse?
    @Published var isVoteMemberLoading: Bool = false
    
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
                        return (image: member.profileImage, status: member.hasVoted)
                    }
                }
                // ✅ 샘플 데이터 로드 성공 메시지
                print("✅ 샘플 데이터 로드 성공: \(response)")
            }
        } catch {
            print("❌ 샘플 데이터 디코딩 실패: \(error)")
        }
    }
    
    // MARK: - API 호출 함수
    func getVoteMember(voteRequest: VoteRequest) {
        isVoteMemberLoading = true
        
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
                self.isVoteMemberLoading = false
                
                switch completion {
                case .finished:
                    print("✅ Get VoteMember Server Completed")
                case .failure(let failure):
                    print("❌ Get VoteMember Failed: \(failure)")
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let result = response.result {
                    self.voteResponse = result
                    self.avatars = result.members.map { member in
                        return (image: member.profileImage, status: member.hasVoted)
                    }
                    
                    // ✅ 성공 메시지 출력
                    print("✅ Get VoteMember 성공: \(result)")
                }
            })
            .store(in: &cancellables)
    }
}
