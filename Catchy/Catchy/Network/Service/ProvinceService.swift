//
//  ProvinceService.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Combine
import Moya

class ProvinceService: ProvinceServiceProtocol, BaseAPIService {
    typealias Target = ProvinceRouter
    
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
    
    func getAccessToken() -> AnyPublisher<ProvinceAccessResponse, Moya.MoyaError> {
        request(.getAccessToken)
    }
    
    func getProvinces(accessToken: String) -> AnyPublisher<ProvinceResponse, Moya.MoyaError> {
        request(.getProvinces(accessToken: accessToken))
    }
    
    func getDistricts(accessToken: String, provinceCode: String) -> AnyPublisher<ProvinceResponse, Moya.MoyaError> {
        request(.getDistricts(accessToken: accessToken, provinceCode: provinceCode))
    }
}
