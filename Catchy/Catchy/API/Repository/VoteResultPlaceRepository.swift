//
//  VoteResultPlaceRepository.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import Moya

/// [카테고리 별 장소 조회] Repository
class VoteResultPlaceRepository: VoteResultPlaceRepositoryProtocol {
    
    private let service: VoteResultPlaceServiceProtocol
    
    init(service: VoteResultPlaceServiceProtocol = VoteResultPlaceService()) {
        self.service = service
    }
    
    func fetchPlacesByCategory(request: VoteResultPlaceRequest) -> AnyPublisher<ResponseData<VoteResultPlaceResponse>, MoyaError> {
        return service.getPlacesByCategory(request: request)
    }
}
