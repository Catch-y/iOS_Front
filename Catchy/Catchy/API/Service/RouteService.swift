//
//  RouteService.swift
//  Catchy
//
//  Created by 정의찬 on 2/19/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

class RouteService: RouteServiceProtocol {
    let provider: MoyaProvider<RouteAPITarget>
    
    init(provider: MoyaProvider<RouteAPITarget> = APIManager.shared.testProvider(for: RouteAPITarget.self)) {
        self.provider = provider
    }
    
    func osrmRouter(locationData: OSRMRequest) -> AnyPublisher<ResponseData<OSRMResponse>, MoyaError> {
        return provider.requestPublisher(.osrmRouter(locationData: locationData))
            .map(ResponseData<OSRMResponse>.self)
            .eraseToAnyPublisher()
    }
}
