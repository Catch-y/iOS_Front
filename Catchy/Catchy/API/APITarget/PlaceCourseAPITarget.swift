//
//  PlaceCourseAPITarget.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation
import Moya

enum PlaceCourseAPITarget {
    
    
    case getPlaceList(place : PlaceSearchRequest)
    
}


extension PlaceCourseAPITarget: APITargetType {
    
    var path: String {
        switch self {
        case .getPlaceList:
            return "/course/place/region"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .getPlaceList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
            
        case .getPlaceList(let place):
            return .requestJSONEncodable(place)
        }
    }
    
    var headers: [String : String]? {
        let header = ["Content-Type" : "application/json"]
        return header
    }
    
    var sampleData: Data {
        switch self {
        case .getPlaceList:
            return  """
              {
                "isSuccess": true,
                "code": "COMMON200",
                "message": "성공입니다.",
                "result": {
                    "placeInfoPreviews": [
                      {
                        "placeId": 1,
                        "placeName": "커피하우스",
                        "placeImage": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        "category": "카페",
                        "roadAddress": "경기 남양주시 와부읍 덕소로2번길 84",
                        "activeTime": "[영업시간] 매일 09:00~22:00",
                        "rating": 4.3,
                        "reviewCount": 124
                      },
                      {
                        "placeId": 2,
                        "placeName": "블랙드롭커피",
                        "placeImage": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        "category": "",
                        "roadAddress": "경기 남양주시 와부읍 덕소로2번길 78",
                        "activeTime": "[영업시간] 매일 09:00~18:00",
                        "rating": 3.7,
                        "reviewCount": 78
                      },
                      {
                        "placeId": 3,
                        "placeName": "스카이라운지",
                        "placeImage": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        "category": "주류",
                        "roadAddress": "경기 남양주시 와부읍 덕소로 72",
                        "activeTime": "[영업시간] 19:00~03:00",
                        "rating": 4.0,
                        "reviewCount": 45
                      },
                      {
                        "placeId": 4,
                        "placeName": "피자나라",
                        "placeImage": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        "category": "음식점",
                        "roadAddress": "경기 남양주시 와부읍 덕소로 87-1",
                        "activeTime": "[영업시간] 11:00~23:00",
                        "rating": 4.2,
                        "reviewCount": 56
                      },
                      {
                        "placeId": 5,
                        "placeName": "미술관 카페",
                        "placeImage": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        "category": "문화생활",
                        "roadAddress": "경기 남양주시 와부읍 덕소로2번길 90",
                        "activeTime": "[영업시간] 10:00~18:00",
                        "rating": 3.5,
                        "reviewCount": 65
                      },
                      {
                        "placeId": 6,
                        "placeName": "클럽나이트",
                        "placeImage": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        "category": "주류",
                        "roadAddress": "경기 남양주시 와부읍 덕소로 89",
                        "activeTime": "[영업시간] 22:00~05:00",
                        "rating": 3.9,
                        "reviewCount": 210
                      },
                      {
                        "placeId": 7,
                        "placeName": "도시락 전문점",
                        "placeImage": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        "category": "",
                        "roadAddress": "경기 남양주시 와부읍 덕소로116번길 23",
                        "activeTime": "[영업시간] 11:00~20:00",
                        "rating": 4.1,
                        "reviewCount": 140
                      },
                      {
                        "placeId": 8,
                        "placeName": "스크린골프",
                        "placeImage": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        "category": "스포츠",
                        "roadAddress": "경기 남양주시 와부읍 덕소로116번길 20",
                        "activeTime": "[영업시간] 09:00~22:00",
                        "rating": 4.2,
                        "reviewCount": 98
                      },
                      {
                        "placeId": 9,
                        "placeName": "도자기 체험",
                        "placeImage": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        "category": "체험",
                        "roadAddress": "경기 남양주시 와부읍 덕소로 94",
                        "activeTime": "[영업시간] 10:00~19:00",
                        "rating": 4.7,
                        "reviewCount": 176
                      },
                      {
                        "placeId": 10,
                        "placeName": "힐링 스파",
                        "placeImage": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        "category": "휴식",
                        "roadAddress": "경기 남양주시 와부읍 덕소로 66-46",
                        "activeTime": "[영업시간] 10:00~20:00",
                        "rating": 4.3,
                        "reviewCount": 432
                      },
                      {
                        "placeId": 11,
                        "placeName": "북카페",
                        "placeImage": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        "category": "카페",
                        "roadAddress": "경기 남양주시 와부읍 덕소로2번길 90",
                        "activeTime": "[영업시간] 09:00~21:00",
                        "rating": 4.5,
                        "reviewCount": 88
                      },
                      {
                        "placeId": 12,
                        "placeName": "드라마관람",
                        "placeImage": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        "category": "문화생활",
                        "roadAddress": "경기 남양주시 와부읍 덕소로 66",
                        "activeTime": "[영업시간] 09:00~18:00",
                        "rating": 4.1,
                        "reviewCount": 134
                      },
                      {
                        "placeId": 13,
                        "placeName": "피트니스",
                        "placeImage": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        "category": "스포츠",
                        "roadAddress": "경기 남양주시 와부읍 덕소로2번길 50",
                        "activeTime": "[영업시간] 06:00~22:00",
                        "rating": 4.4,
                        "reviewCount": 76
                      },
                      {
                        "placeId": 14,
                        "placeName": "이색 체험",
                        "placeImage": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        "category": "",
                        "roadAddress": "경기 남양주시 와부읍 덕소로 70",
                        "activeTime": "[영업시간] 10:00~17:00",
                        "rating": 3.8,
                        "reviewCount": 63
                      },
                      {
                        "placeId": 15,
                        "placeName": "하이볼 바",
                        "placeImage": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        "category": "주류",
                        "roadAddress": "경기 남양주시 와부읍 덕소로116번길 50",
                        "activeTime": "[영업시간] 20:00~04:00",
                        "rating": 3.6,
                        "reviewCount": 112
                      },
                      {
                        "placeId": 16,
                        "placeName": "카페 모던",
                        "placeImage": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        "category": "카페",
                        "roadAddress": "경기 남양주시 와부읍 덕소로 90",
                        "activeTime": "[영업시간] 10:00~22:00",
                        "rating": 4.6,
                        "reviewCount": 87
                      },
                      {
                        "placeId": 17,
                        "placeName": "레스토랑 그라시아",
                        "placeImage": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        "category": "음식점",
                        "roadAddress": "경기 남양주시 와부읍 덕소로116번길 30",
                        "activeTime": "[영업시간] 11:30~22:00",
                        "rating": 4.8,
                        "reviewCount": 92
                      },
                      {
                        "placeId": 18,
                        "placeName": "야경 맛집",
                        "placeImage": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        "category": "문화생활",
                        "roadAddress": "경기 남양주시 와부읍 덕소로 85",
                        "activeTime": "[영업시간] 18:00~23:00",
                        "rating": 4.2,
                        "reviewCount": 150
                      }
                    ],
                "isLast": false
                }
              }


    """.data(using: .utf8)!
       
        }
    }
    
}
