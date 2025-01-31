//
//  PlaceVoteUseCaseProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Moya
import CombineMoya
import Combine



/// [장소 투표/취소] UseCase Protocol
protocol PlaceVoteUseCaseProtocol {
    func executePatchPlaceVote(groupId: Int, voteId: Int, placeVote: PlaceVoteRequest) -> AnyPublisher<ResponseData<PlaceVoteResponse>, MoyaError>
}
