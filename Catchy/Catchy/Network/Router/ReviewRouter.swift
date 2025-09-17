//
//  ReviewRouter.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/15/25.
//

import Foundation
import Moya

enum ReviewRouter {
    /// 리뷰 신고
    case postReport(path: ReviewReportPath, review: ReviewReportRequest)
    /// 내 장소 리뷰 조회
    case getMyPlace(query: ReviewMyPlaceQuery)
    /// 내 코스 리뷰 조회
    case getMyCourse(query: ReviewMyCourseQuery)
    /// 리뷰 삭제
    case deleteReview(path: ReviewDeletePath, query: ReviewDeleteQuery)
}

extension ReviewRouter: APITargetType {
    var path: String {
        switch self {
        case .postReport(let path, _):
            return "/reviews/\(path.reviewId)/report"
        case .getMyPlace:
            return "/mypage/placeReviews"
        case .getMyCourse:
            return "/mypage/courseReviews"
        case .deleteReview(let path, _):
            return "/mypage/reviews/\(path.reviewId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postReport:
            return .post
        case .deleteReview:
            return .delete
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postReport(_, let review):
            return .requestJSONEncodable(review)
        case .getMyPlace(let query):
            return query.asQueryTask()
        case .getMyCourse(let query):
            return query.asQueryTask()
        case .deleteReview(_, let query):
            return query.asQueryTask()
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
