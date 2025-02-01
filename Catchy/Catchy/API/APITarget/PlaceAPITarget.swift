//
//  PlaceAPITarget.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import Foundation
import Moya

/// 장소 관련 API
enum PlaceAPITarget {
    
    /// 장소 평점/리뷰 달기 API
    /// HTTP 메소드 : POST
    /// API Path : /place/{placeId}/review
    case postPlaceReviewSubmission(request: PlaceReviewSubmissionRequest)
    
    /// 장소 좋아요 API
    /// HTTP 메소드 : PATCH
    /// API Path : /place/{placeId}/like
    case patchPlaceLiked(placeId: Int)
}

extension PlaceAPITarget: APITargetType {
    var path: String {
        switch self {
        case .postPlaceReviewSubmission(let request):
            return "/place/\(request.placeId)/review"
        case .patchPlaceLiked(let placeId):
            return "/place/\(placeId)/like"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postPlaceReviewSubmission:
            return .post
        case .patchPlaceLiked:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .postPlaceReviewSubmission(let request):
            return .requestJSONEncodable(request)
        case .patchPlaceLiked:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let header = ["Content-Type": "application/json"]
        return header
    }
    
    var sampleData: Data {
        switch self {
        case .postPlaceReviewSubmission:
            let json = """
            {
                "reviewId": 123,
                "rating": 5,
                "comment": "이 장소 정말 좋네요!",
                "reviewImages": [
                    {
                        "reviewImageId": 101,
                        "imageUrl": "https://example.com/image1.jpg"
                    }
                ],
                "visitedDate": "2025-02-01T03:58:05.299Z",
                "creatorNickname": "JohnDoe"
            }
            """
            return json.data(using: .utf8)!

        case .patchPlaceLiked:
            let json = """
            {
                "placeVisitId": 10,
                "liked": true
            }
            """
            return json.data(using: .utf8)!
        }
    }

}

