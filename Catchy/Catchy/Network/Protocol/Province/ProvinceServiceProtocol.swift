//
//  ProvinceServiceProtocol.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

protocol ProvinceServiceProtocol {
    func getAccessToken() -> AnyPublisher<ProvinceAccessResponse, MoyaError>
    
    func getProvinces(accessToken: String) -> AnyPublisher<ProvinceResponse, MoyaError>
    
    func getDistricts(accessToken: String, provinceCode: String) -> AnyPublisher<ProvinceResponse, MoyaError>
}
