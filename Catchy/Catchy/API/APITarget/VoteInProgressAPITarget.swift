//
//  VoteInProgressAPITarget.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Moya

/// [투표 진행 중] API Target
enum VoteInProgressAPITarget {
    /// 투표 진행 상태 조회
    /// HTTP 메소드: GET
    /// API Path: /vote/{voteId}
    case getVoteInProgress(voteId: Int)
}

extension VoteInProgressAPITarget: APITargetType {
    var path: String {
        switch self {
        case .getVoteInProgress(let voteId):
            return "/vote/\(voteId)"
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
            "message": "투표 진행 상태입니다.",
            "result": {
                "status": "in-progress",
                "totalMembers": 10,
                "results": [
                    {
                        "category": "음식",
                        "voteCount": 5,
                        "votedMembers": [
                            {
                                "memberId": 1,
                                "nickname": "User1",
                                "profileImage": "avatar1"
                            },
                            {
                                "memberId": 2,
                                "nickname": "User2",
                                "profileImage": "avatar2"
                            }
                        ],
                        "rank": 1
                    },
                    {
                        "category": "영화",
                        "voteCount": 3,
                        "votedMembers": [
                            {
                                "memberId": 3,
                                "nickname": "User3",
                                "profileImage": "avatar3"
                            }
                        ],
                        "rank": 2
                    }
                ]
            }
        }
        """
        return jsonString.data(using: .utf8)!
    }
}

