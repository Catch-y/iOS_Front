//
//  PlaceVoteUseCase.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Moya
import CombineMoya
import Combine



/// [장소 투표/취소] UseCase 클래스
class PlaceVoteUseCase: PlaceVoteUseCaseProtocol {
    private let repository: PlaceVoteRepositoryProtocol
    
    init(repository: PlaceVoteRepositoryProtocol = PlaceVoteRepository()) {
        self.repository = repository
    }

    func executePatchPlaceVote(groupId: Int, voteId: Int, placeVote: PlaceVoteRequest) -> AnyPublisher<ResponseData<PlaceVoteResponse>, MoyaError> {
        return repository.patchPlaceVote(groupId: groupId, voteId: voteId, placeVote: placeVote)
    }
}
