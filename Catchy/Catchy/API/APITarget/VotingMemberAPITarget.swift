//
//  Vote.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Moya

/// [코스 관리] API Target
enum VotingMemberAPITarget {
    
    /// 투표중
    /// HTTP 메소드 : GET
    /// API Path : /vote/{groupId}/votes/{voteId}/members
    case getVoteMember(voteRequest: VoteRequest)
    
}

extension VotingMemberAPITarget: APITargetType {
    
    
    var path: String {
        switch self {
        case .getVoteMember:
            return "/vote/{groupId}/votes/{voteId}/members"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getVoteMember:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getVoteMember(let voteRequest):
            return .requestParameters(
                parameters: ["groupId": voteRequest.groupId, "voteId": voteRequest.voteId],
                encoding: URLEncoding.queryString
            )
        }
    }

    
    var headers: [String : String]? {
        let header = ["Content-Type" : "application/json"]
        return header
    }
    
    var sampleData: Data {
            let jsonString = """
            {
                "isSuccess": true,
                "code": "COMMON200",
                "message": "성공입니다.",
                "result": {
                    "totalMembers": 4,
                    "members": [
                        {
                            "memberId": 2,
                            "nickname": "쥬쥬",
                            "profileImage": "avatar2",
                            "hasVoted": true,
                            "voteId": 1
                        },
                        {
                            "memberId": 3,
                            "nickname": "User3",
                            "profileImage": "avatar1",
                            "hasVoted": false,
                            "voteId": 1
                        },
                        {
                            "memberId": 4,
                            "nickname": "User4",
                            "profileImage": "avatar3",
                            "hasVoted": true,
                            "voteId": 1
                        },
                        {
                            "memberId": 5,
                            "nickname": "User5",
                            "profileImage": "avatar4",
                            "hasVoted": false,
                            "voteId": 1
                        }
                    ]
                }
            }

            """.data(using: .utf8)!
            return jsonString
        }
    }
