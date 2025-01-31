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
        case .getPlacesByCategory(let request):
            return "/vote/\(request.groupId)/categories/\(request.category)/places"
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
            "isSuccess": true,
            "code": "SUCCESS",
            "message": "요청 성공",
            "result": {
                "groupLocation": "Seoul",
                "places": [
                    {
                        "placeId": 1,
                        "placeName": "Cafe A",
                        "roadAddress": "123 Main St",
                        "rating": 4.5,
                        "reviewCount": 10,
                        "imageUrl": "https://example.com/image.jpg",
                        "votedMembers": [
                            {
                                "memberId": 1,
                                "nickname": "User1",
                                "profileImage": "https://example.com/avatar1.jpg"
                            }
                        ]
                    }
                ]
            }
        }
        """
        return jsonString.data(using: .utf8)!
    }
}
