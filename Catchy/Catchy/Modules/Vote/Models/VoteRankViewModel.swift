//
//  VoteRankViewModel.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine
import Moya

class VoteRankViewModel: ObservableObject {
    @Published var ranks: [(name: String, count: Int, totalMembers: Int, avatars: [String])] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let provider = MoyaProvider<VoteAPITarget>()
    
    init(groupId: Int, voteId: Int) {
        fetchRanks(groupId: groupId, voteId: voteId)
    }
    
    // MARK: - Fetch Ranks
    func fetchRanks(groupId: Int, voteId: Int) {
        provider.request(.getVoteResults(groupId: groupId, voteId: voteId)) { result in
            switch result {
            case .success(let response):
                do {
                    let jsonString = String(data: response.data, encoding: .utf8) ?? "Invalid Data"
                    print("[응답 JSON]: \(jsonString)")
                    
                    let decodedData = try JSONDecoder().decode(VoteInProgressResponse.self, from: response.data)
                    
                    DispatchQueue.main.async {
                        let totalMembers = decodedData.result.totalMembers
                        self.ranks = decodedData.result.results.map { category in
                            return (name: category.category, count: category.voteCount, totalMembers: totalMembers, avatars: category.votedMembers.map { $0.profileImage })
                        }.sorted { $0.count > $1.count }
                        print("[성공] API 데이터 로드 완료: \(self.ranks)")
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
    
    // MARK: - 샘플 데이터 로드
    private func loadSampleData() {
        guard let sampleResponse = try? JSONDecoder().decode(
            VoteInProgressResponse.self,
            from: VoteAPITarget.getVoteResults(groupId: 1, voteId: 1).sampleData
        ) else {
            print("[오류] 샘플 데이터 디코딩 실패")
            return
        }
        
        DispatchQueue.main.async {
            let totalMembers = sampleResponse.result.totalMembers
            self.ranks = sampleResponse.result.results.map { category in
                return (name: category.category, count: category.voteCount, totalMembers: totalMembers, avatars: category.votedMembers.map { $0.profileImage })
            }.sorted { $0.count > $1.count }
            print("[성공] 샘플 데이터 로드 완료: \(self.ranks)")
        }
    }
}
