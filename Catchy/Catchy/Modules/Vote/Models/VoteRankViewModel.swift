//
//  GroupVoteStartViewModel.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine
import Moya

class VoteRankViewModel: ObservableObject {
    @Published var ranks: [(name: String, count: Int, totalCount: Int, avatars: [String])] = []

    private var cancellables = Set<AnyCancellable>()
    private let provider = MoyaProvider<VoteResultCategoryAPITarget>(stubClosure: MoyaProvider.immediatelyStub) // 샘플 데이터 사용

    init(groupId: Int, voteId: Int) {
        fetchRanks(groupId: groupId, voteId: voteId)
    }

    // MARK: - Fetch Ranks
    func fetchRanks(groupId: Int, voteId: Int) {
        provider.request(.getVoteResultCategory(groupId: groupId, voteId: voteId)) { result in
            switch result {
            case .success(let response):
                do {
                    let jsonString = String(data: response.data, encoding: .utf8) ?? "Invalid Data"
                    print("✅ 응답 JSON: \(jsonString)")

                    let decodedData = try JSONDecoder().decode(ResponseData<VoteResultCategoryResponse>.self, from: response.data)

                    if let categories = decodedData.result?.categories {
                        DispatchQueue.main.async {
                            let totalVotes = categories.reduce(0) { $0 + $1.count }
                            self.ranks = categories.map { category in
                                return (name: category.category, count: category.count, totalCount: totalVotes, avatars: [])
                            }.sorted { $0.count > $1.count }
                        }
                    }
                } catch {
                    print("❌ JSON 디코딩 실패: \(error)")
                }
            case .failure(let error):
                print("❌ 샘플 데이터 요청 실패: \(error.localizedDescription)")
            }
        }
    }
}
