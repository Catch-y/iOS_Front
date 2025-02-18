//
//  RouteRepository.swift
//  Catchy
//
//  Created by 정의찬 on 2/19/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

class RouteRepository: RouteRepositoryProtocol {
    let service: RouteServiceProtocol
    
    init(service: RouteServiceProtocol = RouteService()) {
        self.service = service
    }
    
    func osrmRouterData(locationData: OSRMRequest) -> AnyPublisher<ResponseData<OSRMResponse>, MoyaError> {
        return service.osrmRouter(locationData: locationData)
    }
}
