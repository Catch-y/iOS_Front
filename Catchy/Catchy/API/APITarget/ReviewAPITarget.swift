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
                "totalRating": 4.12,
                "reviewCount": [
                    {
                        "score": 1,
                        "count": 3
                    },
                    {
                        "score": 2,
                        "count": 10
                    },
                    {
                        "score": 3,
                        "count": 50
                    },
                    {
                        "score": 4,
                        "count": 80
                    },
                    {
                        "score": 5,
                        "count": 120
                    }
                ],
                "totalCount": 263,
                "content": [
                    {
                        "reviewId": 6,
                        "comment": "친절한 직원과 깔끔한 시설이 좋았어요!",
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
                        "visitedDate": "2025.01.15",
                        "creatorNickname": "KindGuest"
                    },
                    {
                        "reviewId": 7,
                        "comment": "조용하고 아늑한 분위기라 마음에 들었어요.",
                        "rating": 4,
                        "reviewImages": [],
                        "visitedDate": "2025.01.14",
                        "creatorNickname": "PeaceLover"
                    },
                    {
                        "reviewId": 8,
                        "comment": "가격 대비 성능이 너무 좋아요! 가성비 최고!",
                        "rating": 5,
                        "reviewImages": [
                            {
                                "reviewImageId": 3,
                                "imageUrl": "https://i.namu.wiki/i/IhFrc6uiSNlonNFRXzSNrKrhPKrjpmlmsB_SDg3x0PeW_L06BFuF7mOq8AcPDYjonfNpG64cQYsINU8sICeDpg.webp"
                            }
                        ],
                        "visitedDate": "2025.01.13",
                        "creatorNickname": "BudgetTraveler"
                    },
                    {
                        "reviewId": 9,
                        "comment": "청결 상태가 조금 아쉬웠어요.",
                        "rating": 2,
                        "reviewImages": [],
                        "visitedDate": "2025.01.12",
                        "creatorNickname": "CleanFreak"
                    },
                    {
                        "reviewId": 10,
                        "comment": "뷰가 정말 멋있어요. 사진 찍기 딱 좋습니다!",
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
                        "visitedDate": "2025.01.11",
                        "creatorNickname": "PhotoLover"
                    },
                    {
                        "reviewId": 11,
                        "comment": "커피 맛이 별로였어요. 기대보다 실망했습니다.",
                        "rating": 1,
                        "reviewImages": [],
                        "visitedDate": "2025.01.10",
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

