//
//  GroupAvatarViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import Moya

class GroupAvatarViewModel: ObservableObject {
    
    @Published var avatars: [(id: UUID, imageName: String)] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let provider = MoyaProvider<VoteAPITarget>(stubClosure: MoyaProvider.immediatelyStub)

    // MARK: - API 호출
    func fetchGroupMembers(groupId: Int) {
        isLoading = true
        errorMessage = nil
        
        provider.request(.getVoteMembers(groupId: groupId, voteId: 1)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(BaseResponseVoteMemberListResponse.self, from: response.data)
                    
                    DispatchQueue.main.async {
                        self.isLoading = false
                        
                        if decodedData.isSuccess {
                            self.avatars = decodedData.result.map { member in
                                return (id: UUID(), imageName: member.profileImage)
                            }
                            print("✅ API 데이터 로드 성공: 총 \(self.avatars.count)명")
                        } else {
                            self.errorMessage = decodedData.message
                            print("❌ API 응답 실패: \(decodedData.message ?? "알 수 없는 오류")")
                            self.loadSampleData() // 샘플 데이터 로드
                        }
                    }
                } catch {
                    print("❌ JSON 디코딩 실패:", error)
                    self.loadSampleData() // 샘플 데이터 로드
                }
            case .failure(let error):
                print("❌ API 요청 실패:", error.localizedDescription)
                self.loadSampleData() // 샘플 데이터 로드
            }
        }
    }
    
    // MARK: - 샘플 데이터 로드 함수
    private func loadSampleData() {
        guard let sampleResponse = try? JSONDecoder().decode(
            BaseResponseVoteMemberListResponse.self,
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
                return (id: UUID(), imageName: member.profileImage)
            }
            
            self.isLoading = false
            print("✅ 샘플 데이터 로드 성공: 총 \(self.avatars.count)명")
        }
    }
}
