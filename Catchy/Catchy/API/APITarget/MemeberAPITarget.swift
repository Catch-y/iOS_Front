//
//  MemeberAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 2/3/25.
//

import Foundation
import Moya

enum MemeberAPITarget {
    case patchNickname(nickname: String)
}

extension MemeberAPITarget: APITargetType {
    var path: String {
        switch self {
        case .patchNickname:
            return "/member/mypage/nickname"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .patchNickname:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .patchNickname(let nickname):
            return .requestJSONEncodable(nickname)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
