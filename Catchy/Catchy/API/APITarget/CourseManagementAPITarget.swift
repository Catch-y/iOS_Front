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
    
    /// 코스 조회
    /// HTTP 메소드 : GET
    /// API Path : /course/search
    case getCourseList(course: CourseRequest)
    
}

extension CourseManagementAPITarget: APITargetType {
    
    
    var path: String {
        switch self {
        case .getCourseList:
            return "/course/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCourseList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getCourseList(let course):
            return .requestJSONEncodable(course)
        }
    }
    
    var headers: [String : String]? {
        let header = ["Content-Type" : "application/json"]
        return header
    }
    
    var sampleData: Data {
        let jsonString = """
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
            "categorise": ["RESTAURANT", "CAFE"]
          },
          {
            "courseId": 2,
            "courseType": "AI",
            "courseImage": "https://example.com/images/course2.jpg",
            "courseName": "문화 체험 여행",
            "courseDescription": "다양한 문화와 예술을 체험할 수 있는 코스입니다.",
            "categorise": ["CULTURELIFE", "EXPRERIENCE"]
          },
          {
            "courseId": 3,
            "courseType": "DIY",
            "courseImage": "https://example.com/images/course3.jpg",
            "courseName": "웰니스 힐링 코스",
            "courseDescription": "휴식과 재충전을 위한 웰니스 코스입니다.",
            "categorise": ["REST", "SPORT"]
          },
          {
            "courseId": 4,
            "courseType": "AI",
            "courseImage": "https://example.com/images/course4.jpg",
            "courseName": "카페 투어",
            "courseDescription": "트렌디한 카페를 방문하는 투어입니다.",
            "categorise": ["CAFE"]
          },
          {
            "courseId": 5,
            "courseType": "DIY",
            "courseImage": "https://example.com/images/course5.jpg",
            "courseName": "밤 문화 탐방",
            "courseDescription": "도시의 활기찬 밤 문화를 체험할 수 있는 코스입니다.",
            "categorise": ["BAR"]
          },
          {
            "courseId": 6,
            "courseType": "AI",
            "courseImage": "https://example.com/images/course6.jpg",
            "courseName": "스포츠 어드벤처",
            "courseDescription": "스포츠와 모험을 좋아하는 사람들을 위한 코스입니다.",
            "categorise": ["SPORT", "EXPRERIENCE"]
          },
          {
            "courseId": 7,
            "courseType": "DIY",
            "courseImage": "https://example.com/images/course7.jpg",
            "courseName": "미식 여행",
            "courseDescription": "다양한 음식을 맛볼 수 있는 여행 코스입니다.",
            "categorise": ["RESTAURANT", "CAFE", "BAR"]
          },
          {
            "courseId": 8,
            "courseType": "AI",
            "courseImage": "https://example.com/images/course8.jpg",
            "courseName": "도시 탐험",
            "courseDescription": "도시의 숨겨진 명소를 탐험하는 코스입니다.",
            "categorise": ["CULTURELIFE", "CAFE"]
          },
          {
            "courseId": 9,
            "courseType": "DIY",
            "courseImage": "https://example.com/images/course9.jpg",
            "courseName": "힐링 스팟",
            "courseDescription": "휴식을 취하며 재충전할 수 있는 코스입니다.",
            "categorise": ["REST"]
          },
          {
            "courseId": 10,
            "courseType": "AI",
            "courseImage": "https://example.com/images/course10.jpg",
            "courseName": "창의 워크숍",
            "courseDescription": "창의력을 키울 수 있는 워크숍 코스입니다.",
            "categorise": ["EXPRERIENCE", "CULTURELIFE"]
          },
          {
            "courseId": 11,
            "courseType": "DIY",
            "courseImage": "https://example.com/images/course11.jpg",
            "courseName": "지역 맛집 투어",
            "courseDescription": "현지의 대표 맛집을 방문하는 코스입니다.",
            "categorise": ["RESTAURANT"]
          },
          {
            "courseId": 12,
            "courseType": "AI",
            "courseImage": "https://example.com/images/course12.jpg",
            "courseName": "스포츠 데이",
            "courseDescription": "스포츠 활동을 즐길 수 있는 하루 코스입니다.",
            "categorise": ["SPORT"]
          },
          {
            "courseId": 13,
            "courseType": "DIY",
            "courseImage": "https://example.com/images/course13.jpg",
            "courseName": "문화 여행",
            "courseDescription": "지역의 문화유산을 체험할 수 있는 여행입니다.",
            "categorise": ["CULTURELIFE"]
          },
          {
            "courseId": 14,
            "courseType": "AI",
            "courseImage": "https://example.com/images/course14.jpg",
            "courseName": "바 호핑 투어",
            "courseDescription": "도시 최고의 바를 탐방하는 코스입니다.",
            "categorise": ["BAR"]
          },
          {
            "courseId": 15,
            "courseType": "DIY",
            "courseImage": "https://example.com/images/course15.jpg",
            "courseName": "자연 속 휴식",
            "courseDescription": "자연에서 힐링할 수 있는 코스입니다.",
            "categorise": ["REST", "EXPRERIENCE"]
          },
          {
            "courseId": 16,
            "courseType": "AI",
            "courseImage": "https://example.com/images/course16.jpg",
            "courseName": "예술과 문화",
            "courseDescription": "갤러리와 문화 공간을 탐방하는 코스입니다.",
            "categorise": ["CULTURELIFE", "CAFE"]
          },
          {
            "courseId": 17,
            "courseType": "DIY",
            "courseImage": "https://example.com/images/course17.jpg",
            "courseName": "피트니스 캠프",
            "courseDescription": "건강과 운동을 위한 코스입니다.",
            "categorise": ["SPORT"]
          },
          {
            "courseId": 18,
            "courseType": "AI",
            "courseImage": "https://example.com/images/course18.jpg",
            "courseName": "고급 레스토랑 투어",
            "courseDescription": "최고급 음식을 경험할 수 있는 코스입니다.",
            "categorise": ["RESTAURANT", "BAR"]
          },
          {
            "courseId": 19,
            "courseType": "DIY",
            "courseImage": "https://example.com/images/course19.jpg",
            "courseName": "도시 명소 투어",
            "courseDescription": "도시의 주요 명소를 방문하는 코스입니다.",
            "categorise": ["CULTURELIFE", "RESTAURANT"]
          },
          {
            "courseId": 20,
            "courseType": "AI",
            "courseImage": "https://example.com/images/course20.jpg",
            "courseName": "웰니스 탈출",
            "courseDescription": "스파와 웰니스를 즐길 수 있는 코스입니다.",
            "categorise": ["REST"]
          }
        ],
        "isLast": true
      }
    }
    """.data(using: .utf8)!
        return jsonString
    }
}
