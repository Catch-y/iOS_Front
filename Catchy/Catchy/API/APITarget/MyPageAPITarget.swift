//
//  MyPageAPITarget.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import Foundation
import Moya

/// 마이페이지 APITarget
enum MyPageAPITarget {
    
    /// 프로필 조회 API
    /// HTTP 메소드 : GET
    /// API Path : /member/mypage
    case getProfile
}

extension MyPageAPITarget: APITargetType {
    
    
    var path: String {
        switch self {
            
        /// 프로필 조회 API
        case .getProfile:
            return "/member/mypage"
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        /// 프로필 조회 API
        case .getProfile:
            return .get
        }
    }
    
    var task: Task {
        switch self {
            
        /// 프로필 조회 API
        case .getProfile:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let header = ["Content-Type" : "application/json"]
        return header
    }
    
    var sampleData: Data {
        
        switch self {
            
        /// 프로필 조회 API
        case .getProfile:
            let json = """
            {
              "isSuccess": true,
              "code": "SUCCESS",
              "message": "요청이 성공했습니다.",
              "result": {
                "id": 1,
                "profileImage": "https://i.namu.wiki/i/X93YQGAeHiEm1hB_A-K4VmcmWd5pX02r7DDXWQybf4AToouhB15wfsmcCjqvK5rYoCo9fe3PKL8fRfNHVnepyrupL5KfIP5pN1ryzD298iWlKVDs6vR6v1q-DbuhQKvHQx8AH2NmvVPlWWo7WjV0vw.webp",
                "nickname": "용콩"
              }
            }
            """
            return json.data(using: .utf8)!
        }
    }
}
