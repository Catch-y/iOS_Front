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
    case postServeyCategory(categories: [String])
    case postServeyStyleTime(styleTime: StepThirdRequest)
    case postLocation(locations: [StepFourStep])
}

extension MemeberAPITarget: APITargetType {
    var path: String {
        switch self {
        case .patchNickname:
            return "/member/mypage/nickname"
        case .postServeyCategory:
            return "/member/survey/category"
        case .postServeyStyleTime:
            return "/member/survey/styletime"
        case .postLocation:
            return "/member/survey/location"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .patchNickname:
            return .get
        case .postServeyCategory, .postServeyStyleTime, .postLocation:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .patchNickname(let nickname):
            return .requestJSONEncodable(nickname)
        case .postServeyCategory(let categories):
            return .requestJSONEncodable(categories)
        case .postServeyStyleTime(let styleTime):
            return .requestJSONEncodable(styleTime)
        case .postLocation(let locations):
            return .requestJSONEncodable(locations)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
