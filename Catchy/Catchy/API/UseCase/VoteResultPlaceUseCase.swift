//
//  VoteResultPlaceUseCase.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [카테고리 별 장소 조회] UseCase
class VoteResultPlaceUseCase: VoteResultPlaceUseCaseProtocol {
    private let repository: VoteResultPlaceRepositoryProtocol
    
    init(repository: VoteResultPlaceRepositoryProtocol = VoteResultPlaceRepository()) {
        self.repository = repository
    }
    
    func executeGetPlacesByCategory(voteResultPlaceRequest: VoteResultPlaceRequest) -> AnyPublisher<ResponseData<VoteResultPlaceResponse>, Error> {
        return repository.getPlacesByCategory(voteResultPlaceRequest: voteResultPlaceRequest)
    }
}
