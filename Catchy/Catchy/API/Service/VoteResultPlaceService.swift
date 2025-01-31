

//
//  VoteResultPlaceService.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import Moya

/// [카테고리 별 장소 조회] Service 객체
class VoteResultPlaceService: VoteResultPlaceServiceProtocol {
    
    private let provider: MoyaProvider<VoteResultPlaceAPITarget>
    
    init(provider: MoyaProvider<VoteResultPlaceAPITarget> = MoyaProvider<VoteResultPlaceAPITarget>()) {
        self.provider = provider
    }
    
    func getPlacesByCategory(request: VoteResultPlaceRequest) -> AnyPublisher<ResponseData<VoteResultPlaceResponse>, MoyaError> {
        return provider.requestPublisher(.getPlacesByCategory(request: request))
            .map(ResponseData<VoteResultPlaceResponse>.self)
            .eraseToAnyPublisher()
    }
}
