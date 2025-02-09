//
//   PlaceVoteViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/3/25.
//

import Combine
import Moya
import Foundation

class PlaceVoteViewModel: ObservableObject {
    @Published var isVoteSuccessful: Bool = false
    private let provider = MoyaProvider<PlaceVoteAPITarget>()
    private var cancellables = Set<AnyCancellable>()

    func voteForPlace(groupId: Int, voteId: Int, placeId: Int, isVoted: Bool) {
        let request = PlaceVoteRequest(placeId: placeId, isVoted: isVoted)
        provider.request(.patchPlaceVote(groupId: groupId, voteId: voteId, placeVote: request)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ResponseData<String>.self, from: response.data)
                    if decodedData.isSuccess {
                        DispatchQueue.main.async {
                            self.isVoteSuccessful = true
                        }
                        print("✅ 투표 성공: \(decodedData.message)")
                    } else {
                        print("❌ 투표 실패: \(decodedData.message)")
                    }
                } catch {
                    print("❌ JSON 디코딩 실패: \(error)")
                }
            case .failure(let error):
                print("❌ API 요청 실패: \(error.localizedDescription)")
            }
        }
    }
}
