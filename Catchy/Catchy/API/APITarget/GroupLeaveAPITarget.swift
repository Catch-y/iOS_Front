//
//  GroupLeaveAPITarget.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Moya

/// [그룹 탈퇴] API Target
enum GroupLeaveAPITarget {
    case deleteGroupLeave(groupLeaveRequest: GroupLeaveRequest)
}

extension GroupLeaveAPITarget: APITargetType {
    var path: String {
        switch self {
        case .deleteGroupLeave(let request):
            return "/group/\(request.groupId)/leave"
        }
    }
    
    var method: Moya.Method {
        return .delete
    }
    
    var task: Task {
        switch self {
        case .deleteGroupLeave:
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
            "code": "SUCCESS",
            "message": "그룹에서 탈퇴되었습니다.",
            "result": {}
        }
        """
        return jsonString.data(using: .utf8)!
    }
}
