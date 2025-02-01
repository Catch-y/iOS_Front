//
//  VoteResultPlaceServiceProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import Moya

/// [카테고리 별 장소 조회] Service Protocol
protocol VoteResultPlaceServiceProtocol {
    func getPlacesByCategory(voteResultPlaceRequest: VoteResultPlaceRequest) -> AnyPublisher<ResponseData<VoteResultPlaceResponse>, MoyaError>
}
