//
//  PlaceVoteServiceProtocol 2.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//
import Foundation
import Moya
import CombineMoya
import Combine



/// [장소 투표/취소] Service 클래스
class PlaceVoteService: PlaceVoteServiceProtocol {
    private let provider: MoyaProvider<PlaceVoteAPITarget>
    
    init(provider: MoyaProvider<PlaceVoteAPITarget> = MoyaProvider<PlaceVoteAPITarget>()) {
        self.provider = provider
    }

    func patchPlaceVote(groupId: Int, voteId: Int, placeVote: PlaceVoteRequest) -> AnyPublisher<ResponseData<PlaceVoteResponse>, MoyaError> {
        return provider.requestPublisher(.patchPlaceVote(groupId: groupId, voteId: voteId, placeVote: placeVote))
            .map(ResponseData<PlaceVoteResponse>.self)
            .eraseToAnyPublisher()
    }
}
