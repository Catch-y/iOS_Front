//
//  CourseAPITarget.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Moya

/// [Course] - 코스 관련 API Target
enum CourseAPITarget {
    
    /// 장소 카테고리 선택 API
    /// HTTP 메소드 : POST
    /// API Path : /course/{placeId}
    case postPlaceCategoryRegister(place: PlaceCategoryRegisterRequest)
    
    /// 코스 리뷰 작성 API
    /// HTTP 메소드 : POST
    /// API Path : /course/{courseId}/review
    case postCourseReview(course: CourseReviewRequest)
    
    /// 코스 생성(DIY) API
    /// HTTP 메소드 : POST
    /// API Path : /course/in-person
    case postCreateCourseDIY(course: CourseDIYCreateRequest)
    
    /// 코스 생성(AI) API
    /// HTTP 메소드 : POST
    /// API Path : /course/generate-ai
    case postCreateCourseAI
    
    /// 코스 삭제 API
    /// HTTP 메소드 : DELETE
    /// API Path : /course/{courseId}
    case deleteCourse(courseId: Int)
    
    /// 코스 수정 API
    /// HTTP 메소드 : PATCH
    /// API Path : /course/{courseId}
    case patchCourseEdit(course: CourseEditRequest)
    
    /// 코스 북마크 API
    /// HTTP 메소드 : PATCH
    /// API Path : /course/{courseId}/bookmark
    case patchCourseBookmark(courseId: Int)
    
    /// 장소 방문체크 API
    /// HTTP 메소드 : PATCH
    /// API Path : /course/visited/{placeId}
    case patchPlaceVisit(placeId: Int)
    
    /// 내 코스 조회 API
    /// HTTP 메소드 : GET
    /// API Path : /course/search
    case getCourseList(course: CourseRequest)
    
    /// 코스 상세정보 조회 APi
    /// HTTP 메소드 : GET
    /// API Path : /course/detail/{courseId}
    case getCourseDetail(courseId: Int)
}

extension CourseAPITarget: APITargetType {
    
    
    var path: String {
        switch self {
        case .postPlaceCategoryRegister(let place):
            return "course/\(place.placeId)"
            
        case .postCourseReview(let course):
            return "course/\(course.courseId)/review"
            
        case .postCreateCourseDIY:
            return "course/in-person"
            
        case .postCreateCourseAI:
            return "course/generate-ai"
            
        case .deleteCourse(let courseId):
            return "course/\(courseId)"
            
        case .patchCourseEdit(let course):
            return "course/\(course.courseId)"
            
        case .patchCourseBookmark(let courseId):
            return "course/\(courseId)"
            
        case .patchPlaceVisit(let placeId):
            return "course/visited/\(placeId)"
            
        case .getCourseList:
            return "/course/search"
            
        case .getCourseDetail(let courseId):
            return "/course/detail/\(courseId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postPlaceCategoryRegister:
            return .post
            
        case .postCourseReview:
            return .post
            
        case .postCreateCourseDIY:
            return .post
            
        case .postCreateCourseAI:
            return .post
            
        case .deleteCourse:
            return .delete
            
        case .patchCourseEdit:
            return .patch
        
        case .patchCourseBookmark:
            return .patch
            
        case .patchPlaceVisit:
            return .patch
            
        case .getCourseList:
            return .get
        
        case .getCourseDetail:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .postPlaceCategoryRegister(let place):
            return .requestJSONEncodable(place)
            
        case .postCourseReview(let course):
            return .requestJSONEncodable(course)
            
        case .postCreateCourseDIY(let course):
            return .requestJSONEncodable(course)
            
        case .postCreateCourseAI:
            return .requestPlain
            
        case .deleteCourse(let courseId):
            return .requestJSONEncodable(courseId)
            
        case .patchCourseEdit(let course):
            return .requestJSONEncodable(course)
            
        case .patchCourseBookmark(let courseId):
            return .requestJSONEncodable(courseId)
            
        case .patchPlaceVisit(let placeId):
            return .requestJSONEncodable(placeId)
            
        case .getCourseList(let course):
            return .requestJSONEncodable(course)
        
        case .getCourseDetail(let courseId):
            return .requestJSONEncodable(courseId)
        }
    }
    
    var headers: [String : String]? {
        let header = ["Content-Type" : "application/json"]
        return header
    }
    
    
    var sampleData: Data {
        
        switch self {
        case .postPlaceCategoryRegister:
            return """
            {
              "isSuccess": true,
              "code": "COMMON200",
              "message": "장소 카테고리 등록 성공",
              "result": {}
            }
            """.data(using: .utf8)!
        case .postCourseReview:
            return """
            {
                "isSuccess": true,
                "code": "COMMON200",
                "message": "리뷰 조회 성공",
                "result": {
                  "reviewId": 123,
                  "comment": "음식이 정말 맛있고 분위기도 좋았어요! 다시 방문하고 싶어요.",
                  "reviewImages": [
                    {
                      "reviewImageId": 1,
                      "imageUrl": "https://example.com/images/review1.jpg"
                    },
                    {
                      "reviewImageId": 2,
                      "imageUrl": "https://example.com/images/review2.jpg"
                    }
                  ],
                  "visitedDate": "2024-12-25T19:30:00.000Z",
                  "creatorNickname": "맛집탐험가"
                }
            }
            """.data(using: .utf8)!
        
        case .postCreateCourseDIY:
            return """
            {
              "isSuccess": true,
              "code": "COURSE200",
              "message": "DIY 코스 생성 성공",
              "result": {
                "courseId": 101,
                "courseImage": "https://example.com/images/course1.jpg",
                "courseName": "서울 핫플 투어",
                "courseDescription": "서울의 인기 장소를 방문하는 특별한 여행 코스입니다.",
                "courseType": "DIY",
                "rating": 4.8,
                "reviewCount": 152,
                "recommendTime": "오전 10시 ~ 오후 6시",
                "participantsNumber": 4,
                "placeInfos": [
                  {
                    "placeId": 201,
                    "placeName": "남산 타워",
                    "placeLatitude": 37.5512,
                    "placeLongitude": 126.9882,
                    "isVisited": true
                  },
                  {
                    "placeId": 202,
                    "placeName": "경복궁",
                    "placeLatitude": 37.5796,
                    "placeLongitude": 126.9770,
                    "isVisited": false
                  },
                  {
                    "placeId": 203,
                    "placeName": "이태원",
                    "placeLatitude": 37.5345,
                    "placeLongitude": 126.9940,
                    "isVisited": true
                  }
                ]
              }
            }
            """.data(using: .utf8)!

        case .postCreateCourseAI:
            return """
            {
              "isSuccess": true,
              "code": "COMMON200",
              "message": "코스 정보 조회에 성공했습니다.",
              "result": {
                "courseName": "서울 명소 투어",
                "courseDescription": "서울의 대표적인 명소를 방문하는 코스입니다.",
                "recommendTime": "오전 9시 ~ 오후 6시",
                "courseImage": "https://example.com/images/seoul-tour.jpg",
                "courseRating": 4.7,
                "placeInfos": [
                  {
                    "placeId": 101,
                    "name": "남산 타워",
                    "roadAddress": "서울특별시 용산구 남산공원길 105",
                    "recommendVisitTime": "오후 5시 ~ 오후 9시"
                  },
                  {
                    "placeId": 102,
                    "name": "광장시장",
                    "roadAddress": "서울특별시 종로구 창경궁로 88",
                    "recommendVisitTime": "오전 10시 ~ 오후 3시"
                  },
                  {
                    "placeId": 103,
                    "name": "한강 공원",
                    "roadAddress": "서울특별시 영등포구 여의동로 330",
                    "recommendVisitTime": "오후 2시 ~ 오후 6시"
                  }
                ]
              }
            }
            """.data(using: .utf8)!
            
        case .deleteCourse:
            return """
            {
              "isSuccess": true,
              "code": "COMMON200",
              "message": "코스 삭제 성공했습니다.",
              "result": {}
            }
            """.data(using: .utf8)!
        case .patchCourseEdit:
            return """
            {
              "isSuccess": true,
              "code": "COMMON200",
              "message": "코스 정보를 성공적으로 불러왔습니다.",
              "result": {
                "courseId": 1,
                "courseImage": "https://example.com/images/course1.jpg",
                "courseName": "서울 대표 관광 코스",
                "courseDescription": "서울의 유명한 명소들을 둘러볼 수 있는 코스입니다.",
                "courseType": "AI",
                "rating": 4.8,
                "reviewCount": 152,
                "recommendTime": "오전 10시 ~ 오후 5시",
                "participantsNumber": 20,
                "placeInfos": [
                  {
                    "placeId": 101,
                    "placeName": "경복궁",
                    "placeLatitude": 37.579617,
                    "placeLongitude": 126.977041,
                    "isVisited": true
                  },
                  {
                    "placeId": 102,
                    "placeName": "북촌 한옥마을",
                    "placeLatitude": 37.582604,
                    "placeLongitude": 126.983978,
                    "isVisited": false
                  },
                  {
                    "placeId": 103,
                    "placeName": "남산 서울타워",
                    "placeLatitude": 37.551169,
                    "placeLongitude": 126.988227,
                    "isVisited": true
                  }
                ]
              }
            }
            """.data(using: .utf8)!
        case .patchCourseBookmark:
            return """
            {
                "isSuccess": true,
                "code": "COMMON200",
                "message": "성공했습니다.",
                "result": {
                    "memberCourseId": 0,
                    "bookmarked": true
                }
            }
            """.data(using: .utf8)!
            
        case .patchPlaceVisit:
            return """
            {
              "isSuccess": true,
              "code": "COMMON200",
              "message": "성공했습니다.",
              "result": {}
            }
            """.data(using: .utf8)!
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
            
        case .getCourseDetail:
            return """
            {
              "isSuccess": true,
              "code": "COMMON200",
              "message": "코스 정보를 성공적으로 조회했습니다.",
              "result": {
                "courseId": 10,
                "courseImage": "https://example.com/images/course10.jpg",
                "courseName": "제주도 자연 탐방 코스",
                "courseDescription": "제주도의 아름다운 자연을 감상할 수 있는 코스입니다.",
                "courseType": "AI",
                "rating": 4.7,
                "reviewCount": 85,
                "recommendTime": "오전 9시 ~ 오후 6시",
                "participantsNumber": 15,
                "placeInfos": [
                  {
                    "placeId": 201,
                    "placeName": "성산일출봉",
                    "placeLatitude": 33.45864,
                    "placeLongitude": 126.94225,
                    "isVisited": true
                  },
                  {
                    "placeId": 202,
                    "placeName": "만장굴",
                    "placeLatitude": 33.52723,
                    "placeLongitude": 126.76948,
                    "isVisited": false
                  },
                  {
                    "placeId": 203,
                    "placeName": "우도",
                    "placeLatitude": 33.50830,
                    "placeLongitude": 126.95163,
                    "isVisited": true
                  }
                ]
              }
            }
            """.data(using: .utf8)!

        }
    }
    


   
    

    
}
