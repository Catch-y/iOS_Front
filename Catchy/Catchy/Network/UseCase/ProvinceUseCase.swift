//
//  ProvinceService.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

class ProvinceUseCase: ProvinceUseCaseProtocol {
    private let service: ProvinceServiceProtocol
    
    init(service: ProvinceServiceProtocol = ProvinceService()) {
        self.service = service
    }
    
    /// 시/도 지역 조회를 위한 토큰 생성
    func executeGetAccessToken() -> AnyPublisher<ProvinceAccessResponse, Moya.MoyaError> {
        service.getAccessToken()
    }
    
    /// 시/도 지역 데이터 얻기
    func executeGetProvinces(accessToken: String) -> AnyPublisher<ProvinceResponse, Moya.MoyaError> {
        service.getProvinces(accessToken: accessToken)
    }
    
    /// 시도에 해당하는 구 데이터 얻기
    func executeGetDistricts(accessToken: String, provinceCode: String) -> AnyPublisher<ProvinceResponse, Moya.MoyaError> {
        service.getDistricts(accessToken: accessToken, provinceCode: provinceCode)
    }
}
