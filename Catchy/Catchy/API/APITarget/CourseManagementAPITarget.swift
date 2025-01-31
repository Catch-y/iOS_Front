//
//  CourseManagementAPITarget.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Moya

/// [코스 관리] API Target
enum CourseManagementAPITarget {
    
    /// 내 코스 조회
    /// HTTP 메소드 : GET
    /// API Path : /course/search
    case getCourseList(course: CourseRequest)
    
    /// 장소 검색 - 지역명 기반
    /// HTTP 메소드 : GET
    /// API Path : /course/place/region
    case getPlaceList(place : PlaceSearchRequest)

    /// 장소 검색 - 상세 화면
    /// HTTP 메소드 : GET.
    /// API Path : /course/place/{placeId}
    case getPlaceDetail(placeId: Int)
    
}

extension CourseManagementAPITarget: APITargetType {
    
    
    var path: String {
        switch self {
        case .getCourseList:
            return "/course/search"
        case .getPlaceList:
            return "/course/place/region"
        case .getPlaceDetail(let placeId):
            return "/course/place/\(placeId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCourseList:
            return .get
        case .getPlaceList:
            return .get
        case .getPlaceDetail:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getCourseList(let course):
            return .requestJSONEncodable(course)
        case .getPlaceList(let place):
            return .requestJSONEncodable(place)
        case .getPlaceDetail:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let header = ["Content-Type" : "application/json"]
        return header
    }
    
    
    var sampleData: Data {
        
        switch self {
        case .getCourseList:
            return """
                {
                  "isSuccess": true,
                  "code": "COMMON200",
                  "message": "성공입니다.",
                  "result": {
                    "content": [
                      {
                        "courseId": 1,
                        "courseType": "DIY",
                        "courseImage": "https://example.com/images/course1.jpg",
                        "courseName": "맛집 탐방 코스",
                        "courseDescription": "지역의 인기 맛집을 탐방하는 코스입니다.",
                        "categorise": ["휴식", "카페"]
                      },
                      {
                        "courseId": 2,
                        "courseType": "AI",
                        "courseImage": "https://example.com/images/course2.jpg",
                        "courseName": "문화 체험 여행",
                        "courseDescription": "다양한 문화와 예술을 체험할 수 있는 코스입니다.",
                        "categorise": ["문화생활", "체험"]
                      },
                      {
                        "courseId": 3,
                        "courseType": "DIY",
                        "courseImage": "https://example.com/images/course3.jpg",
                        "courseName": "웰니스 힐링 코스",
                        "courseDescription": "휴식과 재충전을 위한 웰니스 코스입니다.",
                        "categorise": ["휴식", "스포츠"]
                      },
                      {
                        "courseId": 4,
                        "courseType": "AI",
                        "courseImage": "https://example.com/images/course4.jpg",
                        "courseName": "카페 투어",
                        "courseDescription": "트렌디한 카페를 방문하는 투어입니다.",
                        "categorise": ["카페"]
                      },
                      {
                        "courseId": 5,
                        "courseType": "DIY",
                        "courseImage": "https://example.com/images/course5.jpg",
                        "courseName": "밤 문화 탐방",
                        "courseDescription": "도시의 활기찬 밤 문화를 체험할 수 있는 코스입니다.",
                        "categorise": ["주류", "체험", "카페", "음식점"]
                      },
                      {
                        "courseId": 6,
                        "courseType": "AI",
                        "courseImage": "https://example.com/images/course6.jpg",
                        "courseName": "스포츠 어드벤처",
                        "courseDescription": "스포츠와 모험을 좋아하는 사람들을 위한 코스입니다.",
                        "categorise": ["스포츠", "체험", "주류", "카페", "음식점"]
                      },
                      {
                        "courseId": 7,
                        "courseType": "DIY",
                        "courseImage": "https://example.com/images/course7.jpg",
                        "courseName": "미식 여행",
                        "courseDescription": "다양한 음식을 맛볼 수 있는 여행 코스입니다.",
                        "categorise": ["음식점", "카페", "주류"]
                      },
                      {
                        "courseId": 8,
                        "courseType": "AI",
                        "courseImage": "https://example.com/images/course8.jpg",
                        "courseName": "도시 탐험",
                        "courseDescription": "도시의 숨겨진 명소를 탐험하는 코스입니다.",
                        "categorise": ["문화생활", "카페"]
                      },
                      {
                        "courseId": 9,
                        "courseType": "DIY",
                        "courseImage": "https://example.com/images/course9.jpg",
                        "courseName": "힐링 스팟",
                        "courseDescription": "휴식을 취하며 재충전할 수 있는 코스입니다.",
                        "categorise": ["휴식"]
                      },
                      {
                        "courseId": 10,
                        "courseType": "AI",
                        "courseImage": "https://example.com/images/course10.jpg",
                        "courseName": "창의 워크숍",
                        "courseDescription": "창의력을 키울 수 있는 워크숍 코스입니다.",
                        "categorise": ["체험", "문화생활"]
                      },
                      {
                        "courseId": 11,
                        "courseType": "DIY",
                        "courseImage": "https://example.com/images/course11.jpg",
                        "courseName": "지역 맛집 투어",
                        "courseDescription": "현지의 대표 맛집을 방문하는 코스입니다.",
                        "categorise": ["음식점"]
                      },
                      {
                        "courseId": 12,
                        "courseType": "AI",
                        "courseImage": "https://example.com/images/course12.jpg",
                        "courseName": "스포츠 데이",
                        "courseDescription": "스포츠 활동을 즐길 수 있는 하루 코스입니다.",
                        "categorise": ["스포츠"]
                      },
                      {
                        "courseId": 13,
                        "courseType": "DIY",
                        "courseImage": "https://example.com/images/course13.jpg",
                        "courseName": "문화 여행",
                        "courseDescription": "지역의 문화유산을 체험할 수 있는 여행입니다.",
                        "categorise": ["문화생활"]
                      },
                      {
                        "courseId": 14,
                        "courseType": "AI",
                        "courseImage": "https://example.com/images/course14.jpg",
                        "courseName": "바 호핑 투어",
                        "courseDescription": "도시 최고의 바를 탐방하는 코스입니다.",
                        "categorise": ["주류"]
                      },
                      {
                        "courseId": 15,
                        "courseType": "DIY",
                        "courseImage": "https://example.com/images/course15.jpg",
                        "courseName": "자연 속 휴식",
                        "courseDescription": "자연에서 힐링할 수 있는 코스입니다.",
                        "categorise": ["휴식", "체험"]
                      },
                      {
                        "courseId": 16,
                        "courseType": "AI",
                        "courseImage": "https://example.com/images/course16.jpg",
                        "courseName": "예술과 문화",
                        "courseDescription": "갤러리와 문화 공간을 탐방하는 코스입니다.",
                        "categorise": ["문화생활", "카페"]
                      },
                      {
                        "courseId": 17,
                        "courseType": "DIY",
                        "courseImage": "https://example.com/images/course17.jpg",
                        "courseName": "피트니스 캠프",
                        "courseDescription": "건강과 운동을 위한 코스입니다.",
                        "categorise": ["스포츠"]
                      },
                      {
                        "courseId": 18,
                        "courseType": "AI",
                        "courseImage": "https://example.com/images/course18.jpg",
                        "courseName": "고급 레스토랑 투어",
                        "courseDescription": "최고급 음식을 경험할 수 있는 코스입니다.",
                        "categorise": ["음식점", "주류"]
                      },
                      {
                        "courseId": 19,
                        "courseType": "DIY",
                        "courseImage": "https://example.com/images/course19.jpg",
                        "courseName": "도시 명소 투어",
                        "courseDescription": "도시의 주요 명소를 방문하는 코스입니다.",
                        "categorise": ["문화생활", "음식점"]
                      },
                      {
                        "courseId": 20,
                        "courseType": "AI",
                        "courseImage": "https://example.com/images/course20.jpg",
                        "courseName": "웰니스 탈출",
                        "courseDescription": "스파와 웰니스를 즐길 수 있는 코스입니다.",
                        "categorise": ["휴식"]
                      }
                    ],
                    "isLast": true
                  }
                }

                """.data(using: .utf8)!
        
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
            
        case .getPlaceDetail:
            return """
            {
                "isSuccess": true,
                "code": "COMMON200",
                "message": "성공입니다.",
                "result": {
                "placeId": 1,
                "imageUrl": "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                "placeName": "심퍼티쿠시 용산점",
                "placeDescription": "유러피언 요리를 아시안 스타일로 풀어내는 파인캐주얼 레스토랑",
                "categoryName": "음식점",
                "roadAddress": "경기 남양주시 와부읍 덕소로2번길 84",
                "activeTime": "[영업시간] 매일 09:00~22:00",
                "rating": 3,
                "isVisited": true,
                "reviewCount": 21,
                "placeSite": "www.naver.com"
            }
        }
        """.data(using: .utf8)!
                        
        }
    }
    


   
    

    
}
