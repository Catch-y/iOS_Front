//
//  VoteResultPlaceUseCaseProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [카테고리 별 장소 조회] UseCase Protocol
protocol VoteResultPlaceUseCaseProtocol {
    func executeGetPlacesByCategory(voteResultPlaceRequest: VoteResultPlaceRequest) -> AnyPublisher<ResponseData<VoteResultPlaceResponse>, Error>
}
