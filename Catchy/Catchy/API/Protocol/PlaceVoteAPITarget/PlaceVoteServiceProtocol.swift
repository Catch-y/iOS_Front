//
//  PlaceVoteServiceProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [장소 투표/취소] Service Protocol
protocol PlaceVoteServiceProtocol {
    func patchPlaceVote(groupId: Int, voteId: Int, placeVote: PlaceVoteRequest) -> AnyPublisher<ResponseData<PlaceVoteResponse>, MoyaError>
}
