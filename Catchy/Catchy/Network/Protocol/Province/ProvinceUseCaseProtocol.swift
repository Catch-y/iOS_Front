//
//  ProvinceUseCaseProtocol.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

protocol ProvinceUseCaseProtocol {
    func executeGetAccessToken() -> AnyPublisher<ProvinceAccessResponse, MoyaError>
    
    func executeGetProvinces(accessToken: String) -> AnyPublisher<ProvinceResponse, MoyaError>
    
    func executeGetDistricts(accessToken: String, provinceCode: String) -> AnyPublisher<ProvinceResponse, MoyaError>
}
