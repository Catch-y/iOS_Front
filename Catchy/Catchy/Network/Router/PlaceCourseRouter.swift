//
//  PlaceCourseRouter.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/10/25.
//

import Foundation
import Moya

enum PlaceCourseRouter {
    /// 장소 상세 화면
    case getDetailPlace(path: PlaceCourseDetailPath)
    /// 지역명 기반 장소
    case getSearchPlace(query: PlaceCourseSearchQuery)
    /// 좋아요 장소 무한 스크롤
    case getLikeScroll(query: PlaceCourseLikeQuery)
    /// 내 위치 기반 장소 검색
    case getCurrentLocation(query: PlaceCourseCurrentSearchQuery)
}

extension PlaceCourseRouter: APITargetType {
    
    var path: String {
        switch self {
        case .getDetailPlace(let path):
            return "/course/place/\(path.placeId)"
        case .getSearchPlace:
            return "/course/place/region"
        case .getLikeScroll:
            return "/course/place/mypage/like"
        case .getCurrentLocation:
            return "/course/place/mypage/like"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getSearchPlace(let query):
            return query.asQueryTask()
        case .getLikeScroll(let query):
            return query.asQueryTask()
        case .getCurrentLocation(let query):
            return query.asQueryTask()
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
