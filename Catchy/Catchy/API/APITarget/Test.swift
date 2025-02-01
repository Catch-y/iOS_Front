//
//  Test.swift
//  Catchy
//
//  Created by 정의찬 on 2/1/25.
//

import Foundation
import Moya

enum Test {
    case getUserVerifyCode(email: String)
}

extension Test: TargetType {
    var baseURL: URL {
        URL(string: "https://api.example.com")!
    }
    
    var path: String {
        switch self {
        case .getUserVerifyCode:
            return "/users/signup/email/send-verification-code"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserVerifyCode:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getUserVerifyCode(let email):
            return .requestParameters(parameters: ["email": email], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
