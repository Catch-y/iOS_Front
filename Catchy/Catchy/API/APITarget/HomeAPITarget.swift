//
//  HomeAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Moya

enum HomeAPITarget {
    case getSearch(keyword: String)
}

extension HomeAPITarget: APITargetType {
    var path: String {
        switch self {
        case .getSearch:
            return "/home/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSearch:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getSearch(let keyword):
            return .requestJSONEncodable(keyword)
        }
    }
    
    var headers: [String : String]? {
        let header = ["Content-Type" : "application/json"]
        return header
    }
    
    var sampleData: Data {
        switch self {
        case .getSearch:
            let json = """
            {
                "isSuccess": true,
                "code": "200",
                "message": "응답 메세지",
                "result": {
                    "content": [
                        {
                            "placeId": 1,
                            "searchedPlaceName": "SearchPlace",
                            "searchedPlaceCategory": "CAFE",
                            "placeName": "SearchPlace1",
                            "placeImageUrl": "https://i.namu.wiki/i/gBVNMaAFN4xZCQhVVwRheOqrEQcM1WmsM6b6rOeFdOoEuE3nBXZM-7FcVpQXv6GmYj9Je6hbDZNVMWZfqoz9WpVuQ_bQns548g7GMtWDRO_qD_pG2uu5l9ePWpPuOfC92XWX0HMZn2CvOvoZ6p9TyggWZ1At2NLuwE9Fy6pPUbI.webp",
                            "roadAddress": "서울시 용산구 한강대로52길 17-3 1F",
                            "activeTime": "월-금 · 16:00 - 21:00",
                            "reviewCount": 132,
                            "averageRating": 4.6
                        },
                        {
                            "placeId": 2,
                            "searchedPlaceName": "SearchPlace",
                            "searchedPlaceCategory": "CAFE",
                            "placeName": "SearchPlace2",
                            "placeImageUrl": "https://i.namu.wiki/i/gBVNMaAFN4xZCQhVVwRheHH517syiuLKWPDQ8emG8BeFhuEFp6QP4yADbRCW4n-by0Y7OE159lXmUJMkXrXUJLlnuqBjOwjxU8IrDXUOAbordzBwVYmj3NiORAZqBEypeML9E7r-TAwGHRcN9OPJBFlIAoTuJDhExH8RU_W_W4U.webp",
                            "roadAddress": "456 Road Name",
                            "activeTime": "09:00 - 18:00",
                            "reviewCount": 13,
                            "averageRating": 4.6
                        }
                    ]
                }
            }
            """
            return json.data(using: .utf8)!
        }
    }
}
