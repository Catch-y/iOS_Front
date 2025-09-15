//
//  OSRMRouter.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/10/25.
//

import Foundation
import Moya

enum OSRMRouter {
    case osrmRouter(osrm: OSRMRequest)
}

extension OSRMRouter: APITargetType {
    
    var path: String {
        return "/route/"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case .osrmRouter(let osrm):
            return .requestJSONEncodable(osrm)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
}
