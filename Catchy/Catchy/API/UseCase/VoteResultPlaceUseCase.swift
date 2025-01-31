//
//  VoteResultPlaceUseCase.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import Moya

/// [카테고리 별 장소 조회] UseCase
class VoteResultPlaceUseCase: VoteResultPlaceUseCaseProtocol {
    
    private let repository: VoteResultPlaceRepositoryProtocol
    
    init(repository: VoteResultPlaceRepositoryProtocol = VoteResultPlaceRepository()) {
        self.repository = repository
    }
    
    func execute(request: VoteResultPlaceRequest) -> AnyPublisher<ResponseData<VoteResultPlaceResponse>, MoyaError> {
        return repository.fetchPlacesByCategory(request: request)
    }
}
