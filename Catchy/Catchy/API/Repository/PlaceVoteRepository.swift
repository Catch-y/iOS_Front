//
//  PlaceVoteRepository.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Moya
import CombineMoya
import Combine



/// [장소 투표/취소] Repository 클래스
class PlaceVoteRepository: PlaceVoteRepositoryProtocol {
    private let service: PlaceVoteServiceProtocol
    
    init(service: PlaceVoteServiceProtocol = PlaceVoteService()) {
        self.service = service
    }

    func patchPlaceVote(groupId: Int, voteId: Int, placeVote: PlaceVoteRequest) -> AnyPublisher<ResponseData<PlaceVoteResponse>, MoyaError> {
        return service.patchPlaceVote(groupId: groupId, voteId: voteId, placeVote: placeVote)
    }
}
