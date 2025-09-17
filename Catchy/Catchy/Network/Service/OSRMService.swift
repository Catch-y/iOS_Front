//
//  OSRMService.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

class OSRMService: OSRMServiceProtocol, BaseAPIService {
    typealias Target = OSRMRouter
    
    var provider: MoyaProvider<Target>
    var decoder: JSONDecoder
    var callbackQueue: DispatchQueue
    
    init(
        provider: MoyaProvider<Target> = APIManager.shared.createProvider(for: Target.self),
        decoder: JSONDecoder = APIManager.shared.sharedDecoder,
        callbackQueue: DispatchQueue = .main
    ) {
        self.provider = provider
        self.decoder = decoder
        self.callbackQueue = callbackQueue
    }
    
    func getOSRM(osrm: OSRMRequest) -> AnyPublisher<ResponseData<OSRMResponse>, Moya.MoyaError> {
        request(.getOSRM(osrm: osrm))
    }
    
}
