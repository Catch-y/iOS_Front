//
//  VoteResultPlaceRepository.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [카테고리 별 장소 조회] Repository
class VoteResultPlaceRepository: VoteResultPlaceRepositoryProtocol {
    private let service: VoteResultPlaceServiceProtocol
    
    init(service: VoteResultPlaceServiceProtocol = VoteResultPlaceService()) {
        self.service = service
    }
    
    func getPlacesByCategory(voteResultPlaceRequest: VoteResultPlaceRequest) -> AnyPublisher<ResponseData<VoteResultPlaceResponse>, Error> {
        return service.getPlacesByCategory(voteResultPlaceRequest: voteResultPlaceRequest)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
