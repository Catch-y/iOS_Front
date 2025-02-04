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
                                "imageUrl": "https://i.namu.wiki/i/d1A_wD4kuLHmOOFqJdVlOXVt1TWA9NfNt_HA0CS0Y_N0zayUAX8olMuv7odG2FiDLDQZIRBqbPQwBSArXfEJlQ.webp"
                            },
                            {
                                "reviewImageId": 2,
                                "imageUrl": "https://i.namu.wiki/i/PagwakcE00JZaGpEvXym79-IMvKFBmdqOBlq778J-bvJMwz15lDLleTKc56S2wwcRcaEm3FZZ4EtniRa5bXdeQ.webp"
                            }
                        ],
                        "visitedDate": "2025.01.13",
                        "creatorNickname": "Traveler101"
                    },
                    {
                        "reviewId": 2,
                        "comment": "음식은 괜찮았지만 서비스가 조금 아쉬웠어요.",
                        "rating": 3,
                        "reviewImages": [
                            {
                                "reviewImageId": 3,
                                "imageUrl": "https://i.namu.wiki/i/IhFrc6uiSNlonNFRXzSNrKrhPKrjpmlmsB_SDg3x0PeW_L06BFuF7mOq8AcPDYjonfNpG64cQYsINU8sICeDpg.webp"
                            }
                        ],
                        "visitedDate": "2025.01.12",
                        "creatorNickname": "FoodieLover"
                    },
                    {
                        "reviewId": 3,
                        "comment": "가족들과 함께 즐거운 시간을 보냈습니다!",
                        "rating": 4,
                        "reviewImages": [],
                        "visitedDate": "2025.01.10",
                        "creatorNickname": "FamilyFirst"
                    },
                    {
                        "reviewId": 4,
                        "comment": "위치는 좋은데 주변 소음이 조금 있었습니다.",
                        "rating": 2,
                        "reviewImages": [],
                        "visitedDate": "2025.01.09",
                        "creatorNickname": "QuietSeeker"
                    },
                    {
                        "reviewId": 5,
                        "comment": "전반적으로 만족스러운 경험이었습니다. 추천합니다!",
                        "rating": 5,
                        "reviewImages": [
                            {
                                "reviewImageId": 4,
                                "imageUrl": "https://i.namu.wiki/i/abZPxKt_L98I8ttqw56pLHtGiR5pAV4YYmpR3Ny3_n0yvff5IDoKEQFof7EbzJUSZ_-uzR5S7tzTzGQ346Qixw.webp"
                            },
                            {
                                "reviewImageId": 5,
                                "imageUrl": "https://i.namu.wiki/i/XGgP6E-6eOwHuC84pFQpqvTvFAj1VjJQJlOOQV7Ky3MrBzI-IdXGw9r4L1YkCxUv5Uk3rYVWkmWHY8unoh8iSQ.webp"
                            }
                        ],
                        "visitedDate": "2025.01.08",
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

