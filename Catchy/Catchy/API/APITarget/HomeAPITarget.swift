//
//  HomeAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Moya

enum HomeAPITarget {
    case getSearch(keyword: String, page: Int) /* 검색 API */
    case getHomePersonalCourses /* 홈화면 추천 코스 API */
    case getHomeCourseTopTen /* 홈 화면 인기 코스 조회 10 */
    case getRecommendPlaces(userLocation: UserLocation, page: Int) /* 사용자 장소 추천 API */
}

extension HomeAPITarget: APITargetType {
    var path: String {
        switch self {
        case .getSearch:
            return "/course/place/region"
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
        case .getSearch(let keyword, let page):
            return .requestParameters(parameters: ["searchKeyword": keyword, "page": page], encoding: URLEncoding.default)
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
            "placeInfoPreviews": [
              {
                "placeId": 1,
                "placeName": "한강공원",
                "placeImage": "https://media.triple.guide/triple-cms/c_limit,f_auto,h_1024,w_1024/99b67970-512c-4496-bf5c-59472590bcb9.jpeg",
                "category": "BAR",
                "roadAddress": "서울특별시 영등포구 여의도동",
                "activeTime": "24시간",
                "rating": 4.8,
                "reviewCount": 320,
                "liked": true
              },
              {
                "placeId": 2,
                "placeName": "남산 타워",
                "placeImage": "https://parks.seoul.go.kr/images/egovframework/com/template/nam02.jpg",
                "category": "BAR",
                "roadAddress": "서울특별시 용산구 남산공원길",
                "activeTime": "09:00-23:00",
                "rating": 4.7,
                "reviewCount": 410,
                "liked": false
              },
              {
                "placeId": 3,
                "placeName": "홍대 맛집 거리",
                "placeImage": "https://i.namu.wiki/i/-YrQWzgmgedzi-Zpdf6eGXA-NXRhHjGhx7pUsMhUHqfI4mqRv6deS8ZY6xkYYrRBptr5S1GD6iUOHgAGX6bHM0ljC7htlDQtzBMV-BSv5h12dCcD4IyjKCE4aBQR_RrLbFehAybcuJL5hKfE9V0XPg.webp",
                "category": "BAR",
                "roadAddress": "서울특별시 마포구 홍익로",
                "activeTime": "11:00-23:00",
                "rating": 4.6,
                "reviewCount": 280,
                "liked": true
              },
              {
                "placeId": 4,
                "placeName": "경복궁",
                "placeImage": "https://example.com/images/gyeongbokgung.jpg",
                "category": "BAR",
                "roadAddress": "서울특별시 종로구 사직로",
                "activeTime": "09:00-18:00",
                "rating": 4.9,
                "reviewCount": 500,
                "liked": true
              },
              {
                "placeId": 5,
                "placeName": "강남 스타벅스 리저브",
                "placeImage": "https://example.com/images/starbucks.jpg",
                "category": "BAR",
                "roadAddress": "서울특별시 강남구 테헤란로",
                "activeTime": "07:00-22:00",
                "rating": 4.5,
                "reviewCount": 200,
                "liked": false
              }
            ],
            "isLast": true
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
                  "courseName": "한강공원 산책 코스",
                  "courseDescription": "한강을 따라 걷는 아름다운 산책 코스입니다.",
                  "courseImage": "https://mediahub.seoul.go.kr/wp-content/uploads/2014/08/basic_img_000023760.jpg",
                  "courseType": "DIY"
                },
                {
                  "courseId": 2,
                  "courseName": "남산 야경 투어",
                  "courseDescription": "서울의 야경을 감상할 수 있는 대표적인 코스입니다.",
                  "courseImage": "https://i.namu.wiki/i/3gv2CckmpZNQ5C_99hKYqKIH5KIuCKau0OKTiEzK4Tep0ricAnGZMpIJYUvt855yIc8C9TTrHAS511knxDXePppDedmWPZ0PzufrNITUVhPEhAyN9kuWGaFHL3lXuNgrgIIvFEBFEvYWq47doqKb1A.webp",
                  "courseType": "AI"
                },
                {
                  "courseId": 3,
                  "courseName": "홍대 맛집 탐방",
                  "courseDescription": "홍대에서 핫한 맛집들을 탐방하는 미식 코스입니다.",
                  "courseImage": "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FsgE1V%2FbtsI06vs2bl%2FtysnYBbORTcCCT9niOzEL1%2Fimg.jpg",
                  "courseType": "AI"
                },
                {
                  "courseId": 4,
                  "courseName": "제주 올레길 7코스",
                  "courseDescription": "제주의 자연을 만끽할 수 있는 대표적인 올레길 코스입니다.",
                  "courseImage": "https://lh3.googleusercontent.com/p/AF1QipM1QxKKnGOYaD3DadUkr3fJrxTquvyGP2eRhjR2=s1360-w1360-h1020",
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
                  "placeId": 1,
                  "placeName": "한강공원",
                  "placeImage": "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=AVzFdbk6005jgCo4VXN07u047apVy9vYboZRJf1PJy24iAu1Kd7CO87mlWOoeQpojdi4WeGti_bOdOXaTgbaAMxPJPqz6gJKN-_j3rpHPz9RfxV5LauFVs0H_1KeD2qWo34LkKvOLRuMBw9k3-rIxBbufFx9RO5NHr-H9e66Zbf4ONnMxnf7&key=GOOGLE_API_KEY",
                  "category": "공원",
                  "roadAddress": "서울특별시 영등포구 여의도동",
                  "activeTime": "24시간",
                  "rating": 4.8,
                  "reviewCount": 320,
                  "liked": true
                },
                {
                  "placeId": 2,
                  "placeName": "남산 타워",
                  "placeImage": "https://parks.seoul.go.kr/images/egovframework/com/template/nam02.jpg",
                  "category": "관광지",
                  "roadAddress": "서울특별시 용산구 남산공원길",
                  "activeTime": "09:00-23:00",
                  "rating": 4.7,
                  "reviewCount": 410,
                  "liked": false
                },
                {
                  "placeId": 3,
                  "placeName": "홍대 맛집 거리",
                  "placeImage": "https://i.namu.wiki/i/-YrQWzgmgedzi-Zpdf6eGXA-NXRhHjGhx7pUsMhUHqfI4mqRv6deS8ZY6xkYYrRBptr5S1GD6iUOHgAGX6bHM0ljC7htlDQtzBMV-BSv5h12dCcD4IyjKCE4aBQR_RrLbFehAybcuJL5hKfE9V0XPg.webp",
                  "category": "음식점",
                  "roadAddress": "서울특별시 마포구 홍익로",
                  "activeTime": "",
                  "rating": 4.6,
                  "reviewCount": 280,
                  "liked": true
                },
                {
                  "placeId": 4,
                  "placeName": "경복궁",
                  "placeImage": "https://example.com/images/gyeongbokgung.jpg",
                  "category": "역사유적",
                  "roadAddress": "서울특별시 종로구 사직로",
                  "activeTime": "09:00-18:00",
                  "rating": 4.9,
                  "reviewCount": 500,
                  "liked": true
                },
                {
                  "placeId": 5,
                  "placeName": "용산 맛있는 술집",
                  "placeImage": "https://example.com/images/itaewon.jpg",
                  "category": "바 & 펍",
                  "roadAddress": "서울특별시 용산구 이태원로",
                  "activeTime": "",
                  "rating": 4.3,
                  "reviewCount": 180,
                  "liked": false
                },
                {
                  "placeId": 6,
                  "placeName": "북촌 한옥마을",
                  "placeImage": "https://i.namu.wiki/i/QaCF2Kht7snL7P2jR9O-F4sYbwgQNs8FwlNvgBwdjTwHTi15dWaYICrE4ktwAGfD6XG2tmSay5AbntaI4gZ8JFpe8dFtG5gt_Rz5EQVugBz9jXO6fxojSaMVt--BbVsNcI4gDLqJeJpc_OyOy8yR2w.webp",
                  "category": "전통문화",
                  "roadAddress": "서울특별시 종로구 계동길",
                  "activeTime": "",
                  "rating": 4.7,
                  "reviewCount": 350,
                  "liked": true
                },
                {
                  "placeId": 7,
                  "placeName": "강남 스타벅스 리저브",
                  "placeImage": "https://example.com/images/starbucks.jpg",
                  "category": "카페",
                  "roadAddress": "서울특별시 강남구 테헤란로",
                  "activeTime": "07:00-22:00",
                  "rating": 4.5,
                  "reviewCount": 200,
                  "liked": false
                },
                {
                  "placeId": 8,
                  "placeName": "서울숲",
                  "placeImage": "https://example.com/images/seoulforest.jpg",
                  "category": "공원",
                  "roadAddress": "서울특별시 성동구 뚝섬로",
                  "activeTime": "",
                  "rating": 4.8,
                  "reviewCount": 310,
                  "liked": true
                },
                {
                  "placeId": 9,
                  "placeName": "롯데월드",
                  "placeImage": "https://example.com/images/lotteworld.jpg",
                  "category": "놀이공원",
                  "roadAddress": "서울특별시 송파구 올림픽로",
                  "activeTime": "10:00-22:00",
                  "rating": 4.7,
                  "reviewCount": 600,
                  "liked": true
                },
                {
                  "placeId": 10,
                  "placeName": "부산 해운대 해수욕장",
                  "placeImage": "https://example.com/images/haeundae.jpg",
                  "category": "해변",
                  "roadAddress": "부산광역시 해운대구 해운대해변로",
                  "activeTime": "24시간",
                  "rating": 4.6,
                  "reviewCount": 500,
                  "liked": true
                },
                {
                  "placeId": 11,
                  "placeName": "제주 성산일출봉",
                  "placeImage": "https://example.com/images/seongsan.jpg",
                  "category": "자연경관",
                  "roadAddress": "제주특별자치도 서귀포시 성산읍",
                  "activeTime": "07:00-19:00",
                  "rating": 4.9,
                  "reviewCount": 450,
                  "liked": true
                },
                {
                  "placeId": 12,
                  "placeName": "대전 엑스포과학공원",
                  "placeImage": "https://example.com/images/expo.jpg",
                  "category": "과학관",
                  "roadAddress": "대전광역시 유성구 대덕대로",
                  "activeTime": "10:00-18:00",
                  "rating": 4.5,
                  "reviewCount": 220,
                  "liked": false
                },
                {
                  "placeId": 13,
                  "placeName": "광주 양림동 문화마을",
                  "placeImage": "https://example.com/images/yangrim.jpg",
                  "category": "문화마을",
                  "roadAddress": "광주광역시 남구 양림동",
                  "activeTime": "09:00-21:00",
                  "rating": 4.7,
                  "reviewCount": 170,
                  "liked": false
                },
                {
                  "placeId": 14,
                  "placeName": "경주 첨성대",
                  "placeImage": "https://example.com/images/cheomseongdae.jpg",
                  "category": "역사유적",
                  "roadAddress": "경상북도 경주시 첨성로",
                  "activeTime": "09:00-22:00",
                  "rating": 4.8,
                  "reviewCount": 380,
                  "liked": true
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
