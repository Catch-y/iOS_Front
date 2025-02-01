//
//  CreateGroupAPITarget.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Moya

/// [그룹 생성] API Target
enum CreateGroupAPITarget {
    case postCreateGroup(creategroup: CreateGroupRequest)
}

extension CreateGroupAPITarget: APITargetType {
    var path: String {
        switch self {
        case .postCreateGroup:
            return "/group"
        }
    }

    var method: Moya.Method {
        switch self {
        case .postCreateGroup:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .postCreateGroup(let creategroup):
            return .requestJSONEncodable(creategroup)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        let jsonString = """
        {
            "isSuccess": true,
            "code": "GROUP201",
            "message": "그룹이 성공적으로 생성되었습니다.",
            "result": {
                "groupId": 1,
                "groupName": "Study Group",
                "groupLocation": "Seoul",
                "groupImage": "https://image.url",
                "inviteCode": "ABC123",
                "promiseTime": "2025-02-01T05:08:03.006Z",
                "creatorNickname": "JohnDoe"
            }
        }
        """
        return jsonString.data(using: .utf8)!
    }
}
