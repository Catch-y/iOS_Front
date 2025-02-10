//
//  GroupMembersAPITarget.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Moya

/// [그룹 유저 조회] API Target
enum GroupMembersAPITarget {
    /// 그룹 유저 조회
    /// HTTP 메소드: GET
    /// API Path: /group/{groupId}/members
    case getGroupMembers(groupMemberRequest: GroupMembersRequest)
}

extension GroupMembersAPITarget: APITargetType {
    var path: String {
        switch self {
        case .getGroupMembers:
            return "/group/{groupId}/members"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getGroupMembers:
            return .requestPlain
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
            "message": "그룹 유저 조회 성공",
            "result": [
                {
                    "memberId": 1,
                    "nickname": "John Doe",
                    "profileImage": "avatar1"
                },
                {
                    "memberId": 2,
                    "nickname": "Jane Smith",
                    "profileImage": "avatar2"
                }
            ]
        }
        """
        return jsonString.data(using: .utf8)!
    }
}
