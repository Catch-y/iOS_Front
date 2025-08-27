//
//  HomeAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Moya

enum HomeAPITarget {
    case getSearch(keyword: String, page: Int, relevanceScore: Int?, lastPlaceId: Int?) /* 검색 API */
    case getHomePersonalCourses /* 홈화면 추천 코스 API */
    case getHomeCourseTopTen /* 홈 화면 인기 코스 조회 10 */
    case getRecommendPlaces(userLocation: UserLocation, page: Int) /* 사용자 장소 추천 API */
}

extension HomeAPITarget: APITargetType {
    var path: String {
        switch self {
        case .getSearch:
            return "/place/home/search"
        case .getHomePersonalCourses:
            return "/course/home/personal-courses"
        case .getHomeCourseTopTen:
            return "/course/top10"
        case .getRecommendPlaces:
            return "/place/home/recommend-places"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getSearch(let keyword, let page, let relevanceScore, let lastPlaceId):
            var params: [String: Any] = ["keyword": keyword, "pageSize": page]
            if let relevanceScore = relevanceScore {
                params["relevanceScore"] = relevanceScore
            }
            if let lastPlaceId = lastPlaceId {
                params["lastPlaceId"] = lastPlaceId
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)

        case .getHomePersonalCourses:
            return .requestPlain
        case .getHomeCourseTopTen:
            return .requestPlain;
        case .getRecommendPlaces(let userLocation, let page):
            return .requestParameters(parameters: ["latitude": userLocation.latitude,
                                                   "longitude": userLocation.longitude,
                                                   "pageSize": 10,
                                                   "page": page
                                                  ], encoding: URLEncoding.default)
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
                    "placeInfoResponse": {
                      "placeId": 1,
                      "imageUrl": "https://media.triple.guide/triple-cms/c_limit,f_auto,h_1024,w_1024/99b67970-512c-4496-bf5c-59472590bcb9.jpeg",
                      "placeName": "한강공원",
                      "categoryName": "REST",
                      "roadAddress": "서울특별시 영등포구 여의도동",
                      "activeTime": "24시간",
                      "rating": 4.8,
                      "reviewCount": 320
                    },
                    "relevanceScore": 100
                  },
                  {
                    "placeInfoResponse": {
                      "placeId": 2,
                      "imageUrl": "https://parks.seoul.go.kr/images/egovframework/com/template/nam02.jpg",
                      "placeName": "남산 타워",
                      "categoryName": "EXPERIENCE",
                      "roadAddress": "서울특별시 용산구 남산공원길",
                      "activeTime": "09:00-23:00",
                      "rating": 4.7,
                      "reviewCount": 410
                    },
                    "relevanceScore": 90
                  },
                  {
                    "placeInfoResponse": {
                      "placeId": 3,
                      "imageUrl": "https://i.namu.wiki/i/-YrQWzgmgedzi-Zpdf6eGXA-NXRhHjGhx7pUsMhUHqfI4mqRv6deS8ZY6xkYYrRBptr5S1GD6iUOHgAGX6bHM0ljC7htlDQtzBMV-BSv5h12dCcD4IyjKCE4aBQR_RrLbFehAybcuJL5hKfE9V0XPg.webp",
                      "placeName": "홍대 맛집 거리",
                      "categoryName": "RESTAURANT",
                      "roadAddress": "서울특별시 마포구 홍익로",
                      "activeTime": "11:00-23:00",
                      "rating": 4.6,
                      "reviewCount": 280
                    },
                    "relevanceScore": 85
                  },
                  {
                    "placeInfoResponse": {
                      "placeId": 4,
                      "imageUrl": "https://example.com/images/gyeongbokgung.jpg",
                      "placeName": "경복궁",
                      "categoryName": "EXPERIENCE",
                      "roadAddress": "서울특별시 종로구 사직로",
                      "activeTime": "09:00-18:00",
                      "rating": 4.9,
                      "reviewCount": 500
                    },
                    "relevanceScore": 95
                  },
                  {
                    "placeInfoResponse": {
                      "placeId": 5,
                      "imageUrl": "https://example.com/images/starbucks.jpg",
                      "placeName": "강남 스타벅스 리저브",
                      "categoryName": "CAFE",
                      "roadAddress": "서울특별시 강남구 테헤란로",
                      "activeTime": "07:00-22:00",
                      "rating": 4.5,
                      "reviewCount": 200
                    },
                    "relevanceScore": 80
                  }
                ],
                "last": false
              }
            }

            """
            return json.data(using: .utf8)!

            
        case .getHomePersonalCourses:
            let json = """
            {
              "isSuccess": true,
              "code": "200",
              "message": "추천 장소 목록 조회 성공",
              "result": [
                {
                  "courseId": 1,
                  "courseName": "한상차림 올려라 코스",
                  "courseDescription": "한식을 제대로 즐기면서 든든하게 배를 채울 수 있는 정통 한정식 코스입니다. 전채 요리부터 메인, 후식까지 순서대로 나와서 하나하나 음미하면서 먹을 수 있습니다.",
                  "courseImage": "https://catchy-bucket.s3.ap-northeast-2.amazonaws.com/7fd78244-f698-43fb-888c-15c9e0cd9aa5",
                  "courseType": "AI"
                },
                {
                  "courseId": 2,
                  "courseName": "시장 뿌수기 코스",
                  "courseDescription": "전통시장, 재래시장, 야시장까지 싹 다 섭렵하는 리얼 먹방 & 쇼핑 코스!",
                  "courseImage": "https://catchy-bucket.s3.ap-northeast-2.amazonaws.com/course-images/tlwkdQntnrl.png",
                  "courseType": "AI"
                },
                {
                  "courseId": 3,
                  "courseName": "분좋카 코스",
                  "courseDescription": "이 코스는 커피 맛? 그런 거 안 중요함. 일단 조명 은은해야 하고, 음악은 재즈나 시티팝, 가구는 우드톤이면 갑니다.",
                  "courseImage": "https://catchy-bucket.s3.ap-northeast-2.amazonaws.com/course-images/image+(1).png",
                  "courseType": "AI"
                },
                {
                  "courseId": 4,
                  "courseName": "골프치고 밥먹고 카페가고 술까지 코스",
                  "courseDescription": "아침엔 골프, 점심엔 고기, 오후엔 감성 카페, 저녁엔 술… 이게 바로 인생이지.",
                  "courseImage": "https://catchy-bucket.s3.ap-northeast-2.amazonaws.com/course-images/image+(3).png",
                  "courseType": "AI"
                },
                {
                   "courseId": 5,
                   "courseName": "카페갔다가 산책했다가 밥처먹기 풀코스",
                   "courseDescription": "분위기 있게 커피 마시고, 산책으로 힐링하고, 밥으로 마무리하는 인생 코스.",
                   "courseImage": "https://catchy-bucket.s3.ap-northeast-2.amazonaws.com/course-images/image+(3).png",
                   "courseType": "AI"
                }, 
                {
                   "courseId": 6,
                   "courseName": "다이나믹한 놀이공원 풀코스",
                   "courseDescription": "에버랜드에서 신나는 놀이기구를 즐긴 후, 카페에서 여유를 만끽하고, 박물관 감상후 밥까지!",
                   "courseImage": "https://catchy-bucket.s3.ap-northeast-2.amazonaws.com/course-images/image+(4).png",
                   "courseType": "AI"
                }             
              ]
            }
            """
            return json.data(using: .utf8)!
            
        case .getHomeCourseTopTen:
            let json = """
            {
              "isSuccess": true,
              "code": "200",
              "message": "추천 장소 목록 조회 성공",
              "result": [
                {
                  "courseId": 7,
                  "courseImage": "https://i.namu.wiki/i/jDYl3xK8uotCA3p3dD-EFufHlRJPWbYLExnhfIp5YlewDm3FO0lggA4q1xyIpWkoQl-P-NkHuSQ5ZYDzgW_6Sg.webp",
                  "courseName": "월미도 싹-다 깨부수기 코스"
                },
                {
                  "courseId": 8,
                  "courseImage": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfDnd3ze146S8zAHweUxYqxiyh3MxPB3ttXg&s",
                  "courseName": "교양 한 스푼, 미식 한 입"
                },
                {
                  "courseId": 9,
                  "courseImage": "https://i.pinimg.com/474x/31/a8/23/31a82399691863448075ae85980fb14a.jpg",
                  "courseName": "자연과 힐링 코스"
                },
                {
                  "courseId": 10,
                  "courseImage": "https://i.pinimg.com/736x/82/3d/16/823d169d317196afbf0f31b43c954113.jpg",
                  "courseName": "아이도 좋아하는 가족 여행"
                },
                {
                  "courseId": 11,
                  "courseImage": "https://i.pinimg.com/474x/62/f0/32/62f0324981ee60090bd1548da1473767.jpg",
                  "courseName": "친구와 힙찔이 도전할 수 있는 코스"
                },
                {
                  "courseId": 12,
                  "courseImage": "https://i.pinimg.com/736x/6d/0a/dc/6d0adcd2d675349bc9092dd4c3cf9675.jpg",
                  "courseName": "속초로 드라이브 떠나기 ~"
                },
                {
                  "courseId": 13,
                  "courseImage": "https://cdn.mindgil.com/news/photo/202311/78905_21835_147.jpg",
                  "courseName": "실패없는 홍대 데이트 추천!"
                },
                {
                  "courseId": 14,
                  "courseImage": "https://a.travel-assets.com/findyours-php/viewfinder/images/res70/249000/249996-Insadong.jpg",
                  "courseName": "인사동 전통 문화 체험"
                },
                {
                  "courseId": 15,
                  "courseImage": "https://media.triple.guide/triple-cms/c_limit,f_auto,h_1024,w_1024/6287cec8-b327-463a-9fc6-2651c9e2cc57.jpeg",
                  "courseName": "부산 감성 여행 – 바다와 핫플 제대로 즐기기"
                },
                {
                  "courseId": 16,
                  "courseImage": "https://catchy-bucket.s3.ap-northeast-2.amazonaws.com/course-images/image+(5).png",
                  "courseName": "지리산 등반 코스"
                }
              ]
            }
            """

            return json.data(using: .utf8)!
        case .getRecommendPlaces:
            let json = """
            {
              "isSuccess": true,
              "code": "200",
              "message": "추천 장소 목록 조회 성공",
              "result": {
                "content": [
                {
                  "placeId": 42,
                  "placeName": "아이러브휘트스니",
                  "placeImage": "https://lh5.googleusercontent.com/p/AF1QipPHU4LpZjI43dCnwNSqgUbnBwqKPAacofY-1-4Q=w408-h306-k-no",
                  "category": "SPORT",
                  "roadAddress": "서울특별시 서초구  강남대로 27 aT센터 B1",
                  "activeTime": "06:00 ~23:00",
                  "rating": 3.4,
                  "reviewCount": 11,
                  "liked": true
                },
                {
                  "placeId": 43,
                  "placeName": "양재동꽃시장",
                  "placeImage": "https://lh5.googleusercontent.com/p/AF1QipPaf1mkwm3TkXjwYHWsDuGiACK-iCMXSR1fTzz4=w408-h306-k-no",
                  "category": "CULTURELIFE",
                  "roadAddress": "서울특별시 서초구 강남대로 27",
                  "activeTime": "10:00 ~ 08:00",
                  "rating": 3.3,
                  "reviewCount": 1358,
                  "liked": true
                },
                {
                  "placeId": 41,
                  "placeName": "빨강다람쥐 서초 양재시민의숲역점",
                  "placeImage": "https://lh5.googleusercontent.com/p/AF1QipPzwkrGqshnt6h2TfEb16cUZWoXwGnOMsdx8uOW=w426-h240-k-no",
                  "category": "RESTAURANT",
                  "roadAddress": "서울특별시 서초구 양재동 327 1층",
                  "activeTime": "11:00 ~ 10:00",
                  "rating": 4.0,
                  "reviewCount": 280,
                  "liked": true
                },
                {
                  "placeId": 44,
                  "placeName": "오디움 박물관",
                  "placeImage": "https://lh5.googleusercontent.com/p/AF1QipOid1Dx-Ga8hD0h4Sm3ODHWitxwBAPoOTlDm2Gi=w408-h408-k-no",
                  "category": "CULTURELIFE",
                  "roadAddress": "서울특별시 서초구 헌릉로8길 6",
                  "activeTime": "10:00 ~ 18:00",
                  "rating": 4.8,
                  "reviewCount": 51,
                  "liked": true
                },
                {
                  "placeId": 45,
                  "placeName": "이촌한강공원",
                  "placeImage": "https://lh5.googleusercontent.com/p/AF1QipOXYuHIeUKLS6b5qyvzlzJEo9E5s9SnmWQtMkiE=w520-h350-n-k-no",
                  "category": "REST",
                  "roadAddress": "서울특별시 용산구 이촌로72길 62",
                  "activeTime": "00:00 ~ 00:00",
                  "rating": 4.4,
                  "reviewCount": 990,
                  "liked": false
                },
                {
                  "placeId": 46,
                  "placeName": "종로문화체육센터",
                  "placeImage": "https://lh5.googleusercontent.com/p/AF1QipNhikiBVLOMdmOHuIOa3AmJSPn3Kx108oiv_zve=w426-h240-k-no",
                  "category": "SPORT",
                  "roadAddress": "서울특별시 종로구 인왕산로1길 21",
                  "activeTime": "06:00 ~ 21:00",
                  "rating": 4.2,
                  "reviewCount": 215,
                  "liked": true
                },
                {
                  "placeId": 47,
                  "placeName": "바 참",
                  "placeImage": "https://ugc-images.catchtable.co.kr/catchtable/shopinfo/sM2XRwxigdg9JOBbNaHifbg/m/56f7297831654c8c95d5160ed79dd232?details500",
                  "category": "BAR",
                  "roadAddress": "서울특별시 종로구 자하문로7길 34",
                  "activeTime": "07:00-22:00",
                  "rating": 4.8,
                  "reviewCount": 328,
                  "liked": false
                },
                {
                  "placeId": 48,
                  "placeName": "마이너스",
                  "placeImage": "https://lh5.googleusercontent.com/p/AF1QipN-hCeNiW7p5m9KekGe4MQ01tpOiWYL2y9H_8I4=w426-h240-k-no",
                  "category": "BAR",
                  "roadAddress": "서울특별시 용산구 한남동 657-204",
                  "activeTime": "19:30 ~ 00:00",
                  "rating": 4.8,
                  "reviewCount": 310,
                  "liked": true
                },
                {
                  "placeId": 49,
                  "placeName": "한국잡지박물관",
                  "placeImage": "http://archive.magazine.or.kr/resources/images/upload/introduce//4a00f709-950f-440a-8881-5dfe7ea8bd99",
                  "category": "CULTURELIFE",
                  "roadAddress": "서울특별시 영등포구 여의동 44-31",
                  "activeTime": "09:00 ~ 18:00",
                  "rating": 3.5,
                  "reviewCount": 10,
                  "liked": true
                },
                {
                  "placeId": 50,
                  "placeName": "국립과천과학관 유아체험관",
                  "placeImage": "https://lh5.googleusercontent.com/p/AF1QipMt66adosiIFL4_C7QKsn_hZGBcqlcdYaq36Ntt=w532-h240-k-no",
                  "category": "EXPERIENCE",
                  "roadAddress": "경기도 과천시 과천동 상하벌로 110",
                  "activeTime": "09:30 ~ 18:20",
                  "rating": 5.0,
                  "reviewCount": 3,
                  "liked": true
                },
                {
                  "placeId": 51,
                  "placeName": "아라비카",
                  "placeImage": "https://lh5.googleusercontent.com/p/AF1QipMYqaZioMzllMG8Kms7pvN1vI0lE9cfaU0KCGYV=w408-h306-k-no",
                  "category": "CAFE",
                  "roadAddress": "경기도 과천시 문원청계길 39-1",
                  "activeTime": "09:00 ~ 22:10",
                  "rating": 4.4,
                  "reviewCount": 94,
                  "liked": true
                },
                {
                  "placeId": 52,
                  "placeName": "북서울 꿈의숲",
                  "placeImage": "https://lh5.googleusercontent.com/p/AF1QipP3yrMFK2VGHU2qc6rbfuHcIkDyi87orwBjppop=w408-h306-k-no",
                  "category": "REST",
                  "roadAddress": "서울특별시 강북구 월계로 173",
                  "activeTime": "00:00 ~ 00:00",
                  "rating": 4.5,
                  "reviewCount": 4693,
                  "liked": false
                }
              ],
            "isLast": false
                }
            }
            """

            return json.data(using: .utf8)!
        }
    }
}
