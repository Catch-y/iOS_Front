//
//  GroupInviteAPITarget.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Moya

/// [초대 코드로 그룹 정보 조회] API Target
enum GroupInviteAPITarget {
    /// 초대 코드로 그룹 정보 조회
    case getGroupInvite(inviteCode: String)
}

extension GroupInviteAPITarget: APITargetType {
    var path: String {
        switch self {
        case .getGroupInvite(let inviteCode):
            return "/group/invite/\(inviteCode)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        let jsonString = """
        {
            "isSuccess": true,
            "code": "GROUP200",
            "message": "초대 코드로 그룹 정보 조회 성공",
            "result": {
                "groupName": "Study Group",
                "groupLocation": "Seoul",
                "promiseTime": "2025-02-01T07:28:28.596Z",
                "groupImage": "https://example.com/image.jpg"
            }
        }
        """
        return jsonString.data(using: .utf8)!
    }
}
