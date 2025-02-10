//
//  VoteResultPlaceAPITarget.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Moya

/// [카테고리 별 장소 조회] API Target
enum VoteResultPlaceAPITarget {
    case getPlacesByCategory(request: VoteResultPlaceRequest)
}

extension VoteResultPlaceAPITarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://your.api.base.url")! // 실제 API URL로 수정
    }

    var path: String {
        switch self {
        case .getPlacesByCategory:
            return "/vote/{groupId}/categories/{category}/places"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getPlacesByCategory:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getPlacesByCategory:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        let jsonString = """
        {
            "groupLocation": "Seoul",
            "places": [
                {
                    "placeId": 1,
                    "placeName": "스타벅스 용산아이파크점",
                    "roadAddress": "서울 용산구 한강대로 23길 55",
                    "rating": 4.3,
                    "reviewCount": 203,
                    "imageUrl": "starbucksImage",
                    "votedMembers": [
                        {
                            "memberId": 1,
                            "nickname": "User1",
                            "profileImage": "avatar1"
                        }
                    ]
                }
            ]
        }

        """
        return jsonString.data(using: .utf8)!
    }
}
