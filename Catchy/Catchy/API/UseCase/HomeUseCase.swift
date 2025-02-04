//
//  HomeUseCase.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Moya
import Combine

class HomeUseCase: HomeUseCaseProtocol {
    let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
    
    func executeGetSearch(keyword: String) -> AnyPublisher<ResponseData<SearchPlaceResponse>, MoyaError> {
        return repository.getSearchData(keyword: keyword)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
}
