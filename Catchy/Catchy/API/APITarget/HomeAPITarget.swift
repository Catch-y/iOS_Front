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
