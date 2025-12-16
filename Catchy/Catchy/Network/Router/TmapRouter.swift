//
//  OSRMRouter.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/10/25.
//

import Foundation
import Moya

enum TmapRouter {
    case postTmap(tmap: TMapRouteRequest)
}

extension TmapRouter: TargetType {
    var baseURL: URL {
        return URL(string: "https://apis.openapi.sk.com")!
    }
    
    var path: String {
          return "/tmap/routes/pedestrian?version=1"
      }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .postTmap(let tmap):
            return .requestJSONEncodable(tmap)
        }
    }
    
    var headers: [String : String]? {
         return [
             "Content-Type": "application/json",
             "appKey": Config.tmapKey
         ]
     }
}
