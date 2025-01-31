//
//  PlaceCourseAPITarget.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation
import Moya

enum PlaceCourseAPITarget {
    
    /// 장소 상세 화면 API
    /// HTTP 메소드 : GET.
    /// API Path : /course/place/{placeId}
    case getPlaceDetail(placeId: Int)
    
}


extension PlaceCourseAPITarget: APITargetType {
    
    var path: String {
        switch self {
            
        case .getPlaceDetail(let placeId):
            return "/course/place/\(placeId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        case .getPlaceDetail:
            return .get
        }
    }
    
    var task: Task {
        switch self {
            
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
