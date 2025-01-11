//
//  AuthAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation
import Moya

enum AuthAPITarget {
    case sendRefreshToken(refreshToken: String)
}

extension AuthAPITarget: APITargetType {
    var path: String {
        return "test"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        var headers = ["Content-Type": "application/json"]
        
        return headers
    }
}
