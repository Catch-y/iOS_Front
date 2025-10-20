//
//  OSRMUseCase.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

class OSRMUseCase: OSRMUseCaseProtocol {
    private let service: OSRMServiceProtocol
    
    init(service: OSRMServiceProtocol = OSRMService()) {
        self.service = service
    }
    
    /// OSRM 라우팅
    func executeGetOSRM(osrm: OSRMRequest) -> AnyPublisher<ResponseData<OSRMResponse>, Moya.MoyaError> {
        service.getOSRM(osrm: osrm)
    }
}
