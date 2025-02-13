//
//  GroupJoinAPITarget.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Moya

/// [그룹 초대 코드로 가입] API Target
enum GroupJoinAPITarget {
    /// 그룹 초대 코드로 가입
    /// HTTP 메소드: POST
    /// API Path: /group/join
    case postGroupJoin(groupJoinRequest: GroupJoinRequest)
}

extension GroupJoinAPITarget: APITargetType {
    var path: String {
        switch self {
        case .postGroupJoin:
            return "/group/join"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postGroupJoin:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .postGroupJoin(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        let jsonString = """
        {
            "isSuccess": true,
            "code": "GROUP200",
            "message": "그룹에 성공적으로 가입되었습니다.",
            "result": {
                "success": true,
                "message": "가입 성공"
            }
        }
        """
        return jsonString.data(using: .utf8)!
    }
}
