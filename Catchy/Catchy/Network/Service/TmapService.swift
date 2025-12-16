//
//  OSRMService.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

class TmapService: TmapServiceProtocol, BaseAPIService {

    typealias Target = TmapRouter
    
    var provider: MoyaProvider<Target>
    var decoder: JSONDecoder
    var callbackQueue: DispatchQueue
    
    
    init(
        provider: MoyaProvider<Target> = MoyaProvider<Target>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]),
        decoder: JSONDecoder = APIManager.shared.sharedDecoder,
        callbackQueue: DispatchQueue = .main
    ) {
        self.provider = provider
        self.decoder = decoder
        self.callbackQueue = callbackQueue
    }
    
    func postTmap(tmap: TMapRouteRequest) -> AnyPublisher<TMapRouteResponse, Moya.MoyaError> {
        request(.postTmap(tmap: tmap))
    }
    
}
