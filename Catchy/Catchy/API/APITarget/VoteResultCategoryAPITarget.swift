//
//  VoteResultCategoryAPITarget.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//


import Foundation
import Moya

/// [투표 완료 - 카테고리 확인] API Target
enum VoteResultCategoryAPITarget {
    /// 투표 완료 - 카테고리 확인
    /// HTTP 메소드 : GET
    /// API Path : /vote/{groupId}/votes/{voteId}/results
    case getVoteResultCategory(groupId: Int, voteId: Int)
}

extension VoteResultCategoryAPITarget: APITargetType {
    var path: String {
        switch self {
        case .getVoteResultCategory(let groupId, let voteId):
            return "/vote/\(groupId)/votes/\(voteId)/results"
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
            "code": "COMMON200",
            "message": "성공입니다.",
            "result": {
                "groupLocation": "서울",
                "categories": [
                    {
                        "category": "음식점",
                        "count": 15
                    },
                    {
                        "category": "카페",
                        "count": 8
                    }
                ]
            }
        }
        """
        return jsonString.data(using: .utf8)!
    }
}
