//
//  OSRMUseCase.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

class TmapUseCase: TmapUseCaseProtocol {
    private let service: TmapServiceProtocol
    
    init(service: TmapServiceProtocol = TmapService()) {
        self.service = service
    }
    
    func executePostTmap(tmap: TMapRouteRequest) -> AnyPublisher<TMapRouteResponse, MoyaError> {
        service.postTmap(tmap: tmap)
    }
}
