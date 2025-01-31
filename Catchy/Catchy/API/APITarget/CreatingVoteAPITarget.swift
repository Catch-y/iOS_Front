//
//  CreatingVoteAPITarget.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Moya

/// [투표 생성] API Target
enum CreatingVoteAPITarget {
    
    /// 투표 생성
    /// HTTP 메소드 : POST
    /// API Path : /vote
    case postCreateVote(createVote: CreateVoteRequest)
}

extension CreatingVoteAPITarget: APITargetType {

    
    var path: String {
        switch self {
        case .postCreateVote:
            return "/vote"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postCreateVote:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .postCreateVote(let request):
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
            "code": "VOTE201",
            "message": "투표가 성공적으로 생성되었습니다.",
            "result": {
                "voteId": 1
            }
        }
        """.data(using: .utf8)!
        return jsonString
    }
}

