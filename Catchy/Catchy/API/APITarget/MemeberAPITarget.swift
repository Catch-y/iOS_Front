//
//  MemeberAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 2/3/25.
//

import Foundation
import Moya

enum MemeberAPITarget {
    case postNickname(nickname: String) /* 닉네임 중복 검사 */
    case patchNickname(nickname: String) /* 닉네임 변경 */
    case postServeyCategory(categories: [String]) /* 취향 설문 카테고리 저장 */
    case postServeyStyleTime(styleTime: StepThirdRequest) /* 취향 설문 스타일 저장 */
    case postLocation(locations: [StepFourStep]) /* 취향 위치 저장 */
}

extension MemeberAPITarget: APITargetType {
    var path: String {
        switch self {
        case .postNickname:
            return "/member/mypage/nickname"
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
            return .patch
        case .postServeyCategory, .postServeyStyleTime, .postLocation, .postNickname:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .postNickname(let nickname):
            return .requestParameters(parameters: ["nickname": nickname], encoding: JSONEncoding.default)
        case .patchNickname(let nickname):
            return .requestParameters(parameters: ["nickname": nickname], encoding: JSONEncoding.default)
        case .postServeyCategory(let categories):
            return .requestJSONEncodable(["categories": categories])
        case .postServeyStyleTime(let styleTime):
            return .requestJSONEncodable(styleTime)
        case .postLocation(let locations):
            return .requestJSONEncodable(locations)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        switch self {
        case .postNickname:
            return """
                        {
                          "isSuccess": true,
                          "code": "string",
                          "message": "string",
                          "result": {}
                        }
            """.data(using: .utf8)!
        case .patchNickname:
            return """
            {
              "isSuccess": true,
              "code": "string",
              "message": "string",
              "result": {
                "id": 0,
                "nickname": "haha"
              }
            }
            """.data(using: .utf8)!
        case .postServeyCategory:
            return """
            {
              "isSuccess": true,
              "code": "string",
              "message": "string",
              "result": {
                "memberCategoryIds": [
                  1
                ]
              }
            }
            """.data(using: .utf8)!
        case .postServeyStyleTime:
            return """
            {
              "isSuccess": true,
              "code": "string",
              "message": "string",
              "result": {
                "memberStyleSurveyId": [
                  0
                ],
                "activeTimeSurveyId": [
                  1
                ]
              }
            }
            """.data(using: .utf8)!
        case .postLocation:
            return """
            {
              "isSuccess": true,
              "code": "string",
              "message": "string",
              "result": {
                "memberLocationId": [
                  1
                ]
              }
            }
            """.data(using: .utf8)!
        }
    }
}
