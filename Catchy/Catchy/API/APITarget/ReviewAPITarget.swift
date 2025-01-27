//
//  RatingReviewAPITarget.swift
//  Catchy
//
//  Created by 권용빈 on 1/25/25.
//

import Foundation
import Moya

enum ReviewAPITarget {
    case getReviewInfo(placeId: Int, page: Int)
}

extension ReviewAPITarget: APITargetType {
    
    var path: String {
        switch self {
        case .getReviewInfo(let placeId, _):
            return "/place/\(placeId)/review/all"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getReviewInfo:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getReviewInfo(let placeId, _):
            return .requestJSONEncodable(placeId)
        }
    }
    
    var headers: [String : String]? {
        let header = ["Content-Type": "application/json"]
        return header
    }
    
    var sampleData: Data {
        let json = """
        {
            "isSuccess": true,
            "code": "COMMON200",
            "message": "성공입니다.",
            "result": {
                "totalRating": 3.95,
                "reviewCount": [
                    {
                        "score": 1,
                        "count": 2
                    },
                    {
                        "score": 2,
                        "count": 22
                    },
                    {
                        "score": 3,
                        "count": 63
                    },
                    {
                        "score": 4,
                        "count": 68
                    },
                    {
                        "score": 5,
                        "count": 101
                    }
                ],
                "totalCount": 256,
                "content": [
                    {
                        "reviewId": 1,
                        "comment": "이 장소 정말 멋지네요! 분위기도 좋고 다시 방문하고 싶어요.",
                        "rating": 5,
                        "reviewImages": [
                            {
                                "reviewImageId": 1,
                                "imageUrl": "https://example.com/image1.jpg"
                            },
                            {
                                "reviewImageId": 2,
                                "imageUrl": "https://example.com/image2.jpg"
                            }
                        ],
                        "visitedDate": "2025-01-13T05:03:17.752Z",
                        "creatorNickname": "Traveler101"
                    },
                    {
                        "reviewId": 2,
                        "comment": "음식은 괜찮았지만 서비스가 조금 아쉬웠어요.",
                        "rating": 3,
                        "reviewImages": [
                            {
                                "reviewImageId": 3,
                                "imageUrl": "https://example.com/image3.jpg"
                            }
                        ],
                        "visitedDate": "2025-01-12T08:22:45.152Z",
                        "creatorNickname": "FoodieLover"
                    },
                    {
                        "reviewId": 3,
                        "comment": "가족들과 함께 즐거운 시간을 보냈습니다!",
                        "rating": 4,
                        "reviewImages": [],
                        "visitedDate": "2025-01-10T15:30:17.456Z",
                        "creatorNickname": "FamilyFirst"
                    },
                    {
                        "reviewId": 4,
                        "comment": "위치는 좋은데 주변 소음이 조금 있었습니다.",
                        "rating": 2,
                        "reviewImages": [],
                        "visitedDate": "2025-01-09T10:45:12.789Z",
                        "creatorNickname": "QuietSeeker"
                    },
                    {
                        "reviewId": 5,
                        "comment": "전반적으로 만족스러운 경험이었습니다. 추천합니다!",
                        "rating": 5,
                        "reviewImages": [
                            {
                                "reviewImageId": 4,
                                "imageUrl": "https://example.com/image4.jpg"
                            },
                            {
                                "reviewImageId": 5,
                                "imageUrl": "https://example.com/image5.jpg"
                            }
                        ],
                        "visitedDate": "2025-01-08T14:00:00.000Z",
                        "creatorNickname": "HappyCamper"
                    }
                ],
                "last": true
            }
        }

        """
        return json.data(using: .utf8)!
    }
    
}

