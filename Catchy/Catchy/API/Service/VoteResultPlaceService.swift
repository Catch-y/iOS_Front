//
//  VoteResultPlaceService.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [카테고리 별 장소 조회] Service
class VoteResultPlaceService: VoteResultPlaceServiceProtocol {
    private let provider: MoyaProvider<VoteResultPlaceAPITarget>
    
    init(provider: MoyaProvider<VoteResultPlaceAPITarget> = MoyaProvider<VoteResultPlaceAPITarget>()) {
        self.provider = provider
    }
    
    func getPlacesByCategory(voteResultPlaceRequest: VoteResultPlaceRequest) -> AnyPublisher<ResponseData<VoteResultPlaceResponse>, MoyaError> {
        return provider.requestPublisher(.getPlacesByCategory(voteResultPlaceRequest: voteResultPlaceRequest))
            .map(ResponseData<VoteResultPlaceResponse>.self)
            .eraseToAnyPublisher()
    }
}
