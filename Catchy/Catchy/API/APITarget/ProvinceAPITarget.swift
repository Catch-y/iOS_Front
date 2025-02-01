//
//  ProvinceAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 2/1/25.
//

import Foundation
import Moya

enum ProvinceAPITarget {
    case getAccessToken
    case getProvinces(accessToken: String)
    case getDistricts(accessToken: String, provinceCode: String)
}

extension ProvinceAPITarget: TargetType {
    var baseURL: URL {
        URL(string: "https://sgisapi.kostat.go.kr")!
    }
    
    var path: String {
        switch self {
        case .getAccessToken:
            return "/OpenAPI3/auth/authentication.json"
        case .getProvinces, .getDistricts:
            return "/OpenAPI3/addr/stage.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAccessToken, .getProvinces, .getDistricts:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getAccessToken:
            return .requestParameters(parameters: ["consumer_key": Config.consumerKey, "consumer_secret": Config.consumerSecretKey], encoding: URLEncoding.default)
        case .getProvinces(let accessToken):
            return .requestParameters(parameters: ["accessToken": accessToken, "pg_yn": 0], encoding: URLEncoding.default)
        case .getDistricts(let accessToken, let provinceCode):
            return .requestParameters(parameters: ["accessToken": accessToken, "cd": provinceCode, "pg_yn": 0], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
