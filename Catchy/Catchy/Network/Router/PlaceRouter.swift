//
//  PlaceRouter.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/10/25.
//

import Foundation
import Moya

enum PlaceRouter {
    /// 장소 평점/리뷰 달기
    case postReview(path: PlaceReviewPath, place: PlaceReviewRequest)
    /// 장소 좋아요
    case pathLike(path: PlaceLikePath)
    /// 장소리뷰 전체 조회
    case getPlaceReview(path: PlaceAllReviewPath, query: PlaceAllReviewQuery)
    /// 장소 방문 날짜
    case getPlaceVisit(path: PlaceVisitListPath)
    /// 장소 검색
    case getPlaceSearch(query: PlaceSearchQuery)
    /// 사용자 장소 추천
    case getPlaceRecommend(query: PlaceRecommendQuery)
}

extension PlaceRouter: APITargetType {
    var path: String {
        switch self {
        case .postReview(let path, _):
            return "/place/\(path.placeId)/review"
        case .pathLike(let path):
            return "/place/\(path.placeId)/like"
        case .getPlaceReview(let path, _):
            return "/place/\(path.placeId)/review/all"
        case .getPlaceVisit(let path):
            return "/place/\(path.courseId)/\(path.placeId)/visit"
        case .getPlaceSearch:
            return "/place/home/search"
        case .getPlaceRecommend:
            return "/place/home/recommend-places"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postReview:
            return .post
        case .pathLike:
            return .patch
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postReview(_, let place):
            return .uploadMultipart(place.asMultipartFormData())
        case .getPlaceReview(_, let query):
            return query.asQueryTask()
        case .getPlaceSearch(let query):
            return query.asQueryTask()
        case .getPlaceRecommend(let query):
            return query.asQueryTask()
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postReview:
            return ["Content-Type": "multipart/form-data"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
    
}
