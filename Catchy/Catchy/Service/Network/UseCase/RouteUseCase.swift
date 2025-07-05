//
//  RouteUseCase.swift
//  Catchy
//
//  Created by 정의찬 on 2/19/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

class RouteUseCase: RouteUseCaseProtocol {
    let repository: RouteRepositoryProtocol
    
    init(repository: RouteRepositoryProtocol = RouteRepository()) {
        self.repository = repository
    }
    
    func executeOsrmRouter(locationData: OSRMRequest) -> AnyPublisher<ResponseData<OSRMResponse>, Moya.MoyaError> {
        return repository.osrmRouterData(locationData: locationData)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
}
