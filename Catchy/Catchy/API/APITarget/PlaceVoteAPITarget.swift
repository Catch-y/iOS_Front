//
//  PlaceVoteAPITarget.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Moya

/// [장소 투표/취소] API Target
enum PlaceVoteAPITarget {
    /// 장소 투표/취소
    /// HTTP 메소드 : PATCH
    /// API Path : /vote/{groupId}/{voteId}/places/vote
    case patchPlaceVote(groupId: Int, voteId: Int, placeVote: PlaceVoteRequest)
}

extension PlaceVoteAPITarget: APITargetType {
    var path: String {
        switch self {
        case .patchPlaceVote(let groupId, let voteId, _):
            return "/vote/\(groupId)/\(voteId)/places/vote"
        }
    }

    var method: Moya.Method {
        switch self {
        case .patchPlaceVote:
            return .patch
        }
    }

    var task: Task {
        switch self {
        case .patchPlaceVote(_, _, let placeVote):
            return .requestJSONEncodable(placeVote)
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
            "result": "string"
        }
        """
        return jsonString.data(using: .utf8)!
    }
}
