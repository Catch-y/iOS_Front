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
                  "courseId": 1,
                  "courseImage": "https://i.namu.wiki/i/PsAbvcWd3-b34riJb_5Eert_JxHr2DLLKBJdHxltjnd71xEgdS62jB64nl58t8GmThR0cpy52gYCAc83h2srIhrrcQx50vOz2thIJdWP7Yz7QpS62SqusN7YRVbWEOpxgYX3Wpdqb28pUJSrSwbHMQ.webp",
                  "courseName": "경복궁 코스"
                },
                {
                  "courseId": 2,
                  "courseImage": "https://i.namu.wiki/i/Y0ct-pk-0QesZIcfe0WDD38Igs2LRwQaqCwF68KGDjlu_4VPcugTvUmV3VOWldjSkSRLK1aivMiJzNnlVTLlq5MpQ-c7qUVZvZOYYtdiGb14lPF3pqFcHTbvxNC968Kf3HqdcgPTzyC-CpE7xykb0w.webp",
                  "courseName": "숭례문 야경 투어"
                },
                {
                  "courseId": 3,
                  "courseImage": "https://i.namu.wiki/i/IS7i8wmi-5dVMZoBm2inIIL83aNQOcp61Zp5z93AxAm6cDbCyjV8277WQBxG8JAOjzdtDtz14Qir0WWu1ccB4nMfnfMNUepNjcEzmruhazZeoOSFXvlMJiJYj3r7v_FHsPu60BqBoQ7o3YRd1rA6MA.webp",
                  "courseName": "덕수궁 미치게 재밌느 코스"
                },
                {
                  "courseId": 4,
                  "courseImage": "https://i.namu.wiki/i/weAgIrSScXTmwtFhlw09cpqD_sbUIkOw4yq68Bl4N4oU1ZdDQhaxwtunO1c3gAf5nVyVv3dE02osHDJbRmAda_-NTY99gb6KAfKl5JKhDCpsQNar5IuJQhJqFuKuhMt6hUVMm8YhBjGZeKj9tIMLZg.webp",
                  "courseName": "한라산 등산 가보자고~"
                },
                {
                  "courseId": 5,
                  "courseImage": "https://i.namu.wiki/i/rM1WrmcSNcqq1bAN2PxXXRAICDet0vO_Ef05nxH6Pe-m4FbzjP_dsfrFhLQJIgDa74zYU_ZLlROCB6Uw-9KGXybB9e-YYYdFPYY6MC3juv6t7A0IVaclsV0lh7T6-4SMPvFdp77OJAnoaDe2zSO7iA.webp",
                  "courseName": "북촌 한옥마을 산책"
                },
                {
                  "courseId": 6,
                  "courseImage": "https://i.namu.wiki/i/Ca6uA8jti6jQfstU5FzeSH6bnn9Ms8uoWBMROytYU606IZ0GLj4d8RWEAQpV3PUP1FjsuemL2y-QlMwp-m1JiQl-ZXmKvkKDfsFNK93VrWiFP9Tv7Yz71eOmMJnBKGHfQEFIfGODpVi3lwxEll8eAw.webp",
                  "courseName": "경복궁 야간 개장"
                },
                {
                  "courseId": 7,
                  "courseImage": "https://i.namu.wiki/i/3gv2CckmpZNQ5C_99hKYqKIH5KIuCKau0OKTiEzK4Tep0ricAnGZMpIJYUvt855yIc8C9TTrHAS511knxDXePppDedmWPZ0PzufrNITUVhPEhAyN9kuWGaFHL3lXuNgrgIIvFEBFEvYWq47doqKb1A.webp",
                  "courseName": "서울타워 전망대 투어"
                },
                {
                  "courseId": 8,
                  "courseImage": "https://a.travel-assets.com/findyours-php/viewfinder/images/res70/249000/249996-Insadong.jpg",
                  "courseName": "인사동 전통 문화 체험"
                },
                {
                  "courseId": 9,
                  "courseImage": "https://blog-static.kkday.com/ko/blog/wp-content/uploads/korea_gangneung_beach_anmokbeach_1.jpg",
                  "courseName": "강릉 바다 드라이브"
                },
                {
                  "courseId": 10,
                  "courseImage": "https://i.namu.wiki/i/a6fOOb7VI-_0QoTSQ3N3IxWimD3ydoKg1y7higuSmkoU7p5BIstpjyVEdUqsrZrVHYfkoWgU38TUyQfORQkD66O6IE_nz1AkXO9jeaXtqKDZZ2wQV05JD0U1gcj74sHvgDjJ3PpzQmh_xN9FFuViJw.webp",
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
