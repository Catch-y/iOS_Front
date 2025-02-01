//
//  MyGroupsAPITarget.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Moya

/// [사용자가 속한 그룹 조회] API Target
enum MyGroupsAPITarget {
    /// 그룹 조회
    case getMyGroups(myGroupRequest: MyGroupsRequest)
}

extension MyGroupsAPITarget: APITargetType {
    var path: String {
        return "/group/my-groups"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getMyGroups(let myGroupRequest):
            return .requestParameters(parameters: ["page": myGroupRequest.page, "size": myGroupRequest.size], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        let jsonString = """
        {
            "isSuccess": true,
            "code": "string",
            "message": "string",
            "result": {
                "size": 10,
                "content": [
                    {
                        "groupId": 1,
                        "groupName": "Group 1",
                        "promiseTime": "2025-02-01T07:20:10.360Z"
                    },
                    {
                        "groupId": 2,
                        "groupName": "Group 2",
                        "promiseTime": "2025-02-01T08:20:10.360Z"
                    }
                ],
                "number": 0,
                "sort": {
                    "empty": true,
                    "unsorted": true,
                    "sorted": true
                },
                "numberOfElements": 2,
                "pageable": {
                    "offset": 0,
                    "sort": {
                        "empty": true,
                        "unsorted": true,
                        "sorted": true
                    },
                    "unpaged": false,
                    "paged": true,
                    "pageNumber": 0,
                    "pageSize": 10
                },
                "first": true,
                "last": false,
                "empty": false
            }
        }
        """
        return jsonString.data(using: .utf8)!
    }
}
