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
    
    /// 장소 검색 - 지역명 기반
    /// HTTP 메소드 : GET
    /// API Path : /course/place/region
    case getPlaceList(place : PlaceSearchRequest)
    
}

extension CourseManagementAPITarget: APITargetType {
    
    
    var path: String {
        switch self {
        case .getCourseList:
            return "/course/search"
        case .getPlaceList:
            return "/course/place/region"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCourseList:
            return .get
        case .getPlaceList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getCourseList(let course):
            return .requestJSONEncodable(course)
        case .getPlaceList(let place):
            return .requestJSONEncodable(place)
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
        "placeInfoPreviews": [
          {
            "placeId": 1,
            "placeName": "커피에리어",
            "placeImage": "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=AVzFdblZbagJ74Nav7gKViv_BRYLnx4JzJLQLTqgTzwQUj9-UPOvXnvr0Xd7v2NKuCkbzMZrX1NKRyfACzZU_n0PlQ4qWyL5YFUvHd7LgF3QFepYs03u9CFEqv-T3_y1U05KLDcIUBFjErBq3qmtkWoCSMoOFOAGF9gbCNvKMQBqZulSwLmD&key=GOOGLE_API_KEY",
            "category": "프랜차이즈",
            "roadAddress": "경기 남양주시 와부읍 덕소로2번길 84",
            "activeTime": "[영업시간]매일 09:00~22:00;",
            "rating": 0,
            "reviewCount": 0
          },
          {
            "placeId": 2,
            "placeName": "블랙드롭커피 덕소강변점",
            "placeImage": "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=&key=GOOGLE_API_KEY",
            "category": "프랜차이즈",
            "roadAddress": "경기 남양주시 와부읍 덕소로2번길 78",
            "activeTime": "[영업시간]매일 09:00~18:00;[휴무]연중무휴;",
            "rating": 0,
            "reviewCount": 0
          },
          {
            "placeId": 3,
            "placeName": "카페베네 덕소역점",
            "placeImage": "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=&key=GOOGLE_API_KEY",
            "category": "",
            "roadAddress": "경기 남양주시 와부읍 덕소로 72",
            "activeTime": "[영업시간]07:00~24:00;[좌석수]127;[휴무]연중무휴;",
            "rating": 0,
            "reviewCount": 0
          },
          {
            "placeId": 4,
            "placeName": "이디야커피 덕소삼거리점",
            "placeImage": "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=&key=GOOGLE_API_KEY",
            "category": "",
            "roadAddress": "경기 남양주시 와부읍 덕소로 87-1",
            "activeTime": "[영업시간]09:00~23:00;",
            "rating": 0,
            "reviewCount": 0
          },
          {
            "placeId": 5,
            "placeName": "달콤커피 덕소리버사이드점",
            "placeImage": "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=AVzFdblFeDTCnCog1onHLpn-hpqrKiBCpIAeLkpxaYBGUmHeCOa8duxb9jOHj_9omnaNMAEDhoaSncwV-f2N7AiVhnGjN1sfF9-jC895r9le_Ydo6cHlxXOdRtk1h7AxiVi31Ogw3e2dWxw7Dea1hMDRQN0Md0xoOK8sttIw_rsLzlO41nyp&key=GOOGLE_API_KEY",
            "category": "",
            "roadAddress": "경기 남양주시 와부읍 덕소로2번길 90",
            "activeTime": "[영업시간]매일 08:00~23:00;",
            "rating": 0,
            "reviewCount": 0
          },
          {
            "placeId": 6,
            "placeName": "메가커피 덕소삼거리점",
            "placeImage": "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=AVzFdbkXxFkrKs0f2WKQopYxeNSBg1v3rYOZB51PZmgY9eeCb1cIH1eI_HJj1McFFDHIXazMfS2NqOBnqW-MYcBKWK0JbSL35dS9cWQQnAE130-cG5OVdOP_pDLSkDeSOlg-YDHi-PEE0MkK2b17D9pQJVr-32Oz1yW3ZGb92aALmlgvuNky&key=GOOGLE_API_KEY",
            "category": "",
            "roadAddress": "경기 남양주시 와부읍 덕소로 89",
            "activeTime": "",
            "rating": 0,
            "reviewCount": 0
          },
          {
            "placeId": 7,
            "placeName": "센틴컵",
            "placeImage": "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=AVzFdbkdcDvmrPtomI33u2xkfQCxgyL73FwfE3ChLqlWHegRK6VNlLw0x0OmwiEPno0DX6WCzSB_5Z-PZdHqo3O5dmJV3QOEZRgi5D58_wWZwpB-ObbC0928FW7pFNhYN1cWbk1bbTLzOiM-n6bLO_dHO_eoj7eZiz6bce51PrNVlT_vGFAu&key=GOOGLE_API_KEY",
            "category": "",
            "roadAddress": "경기 남양주시 와부읍 덕소로116번길 23",
            "activeTime": "",
            "rating": 0,
            "reviewCount": 0
          },
          {
            "placeId": 8,
            "placeName": "러브프롬",
            "placeImage": "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=&key=GOOGLE_API_KEY",
            "category": "",
            "roadAddress": "경기 남양주시 와부읍 덕소로116번길 20",
            "activeTime": "",
            "rating": 0,
            "reviewCount": 0
          },
          {
            "placeId": 9,
            "placeName": "설빙 덕소점",
            "placeImage": "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=AVzFdbmH7Akg_wXuX1kk-0qorPJIYibbBq6g7UoGvMw6fp_hoYNopY10whQd2MilSGv3v7e_J8JFqw6naeC9jwCWx1BuR_lVeSQQLLfXc3tN2S5ru2Wt6j8JA_CEJ9gb7zXbR0LTJr6t4p3Qsk_P4aWsF8Mph3_P-A9FJ-cYYXSVa8yj7SQl&key=GOOGLE_API_KEY",
            "category": "",
            "roadAddress": "경기 남양주시 와부읍 덕소로 94",
            "activeTime": "[휴무]연중무휴;",
            "rating": 0,
            "reviewCount": 0
          },
          {
            "placeId": 10,
            "placeName": "스테이얼라이브",
            "placeImage": "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=AVzFdbmFgwlZR7Vtx2ica_RkDJOTxLvqleAnxhl4KJrpst-_5LnW4P9nRNTTruT2J1V6kZx2XBkIza5W9NMi66hpe0FpOTFgNa3wcdwtnfhiAmI_JinhRIip6HLomRNH-iOxKgGwJ3XjaMVDdau1L3q_ge5EiiYM8rnyV0oIjGpj1ps2v0Fc&key=GOOGLE_API_KEY",
            "category": "",
            "roadAddress": "경기 남양주시 와부읍 덕소로 66-46",
            "activeTime": "[영업시간]평일 08:00~18:00;토 08:00~18:00;일 12:00~18:00;",
            "rating": 0,
            "reviewCount": 0
          }
        ],
        "isLast": false
      }
    } 
""".data(using: .utf8)!
        return jsonString
        
    }
    
}
