//
//  PlaceAPITarget.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import Foundation
import Moya
import SwiftUI

/// 장소 관련 API
enum PlaceAPITarget {
    
    /// 장소 평점/리뷰 달기 API
    /// HTTP 메소드 : POST
    /// API Path : /place/{placeId}/review
    case postPlaceReviewSubmission(placeId: Int, request: PlaceReviewSubmissionRequest, reviewImages: [UIImage])
    
    /// 장소 좋아요 API
    /// HTTP 메소드 : PATCH
    /// API Path : /place/{placeId}/like
    case patchPlaceLiked(placeId: Int)
    
    /// 장소 방문 날짜 리스트 조회 API
    /// HTTP 메소드 : GET
    /// API Path: /place/{placeId}/visit
    case getVisitedDateList(placeId: Int)
}

extension PlaceAPITarget: APITargetType {
    var path: String {
        switch self {
        case .postPlaceReviewSubmission(let placeId, _ , _ ):
            return "/place/\(placeId)/review"
        case .patchPlaceLiked(let placeId):
            return "/place/\(placeId)/like"
        case .getVisitedDateList(let placeId):
            return "/place/\(placeId)/visit"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postPlaceReviewSubmission:
            return .post
        case .patchPlaceLiked:
            return .patch
        case .getVisitedDateList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .postPlaceReviewSubmission( _, let request, let images):
            let formData = encodeReviewData(reviewRequest: request, reviewImages: images)
            return .uploadMultipart(formData)
            
        case .patchPlaceLiked:
            return .requestPlain
            
        case .getVisitedDateList:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postPlaceReviewSubmission:
            return ["Content-Type": "multipart/form-data"]
        default :
            return ["Content-Type": "application/json"]
        }
    
    }
    
    var sampleData: Data {
        switch self {
        case .postPlaceReviewSubmission:
            let json = """
            {
                "isSuccess": true,
                "code": "SUCCESS",
                "message": "요청이 성공했습니다.",
                "result": {
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
            }
            """
            
            return json.data(using: .utf8)!

        case .patchPlaceLiked:
            let json = """
            {
                "isSuccess": true,
                "code": "SUCCESS",
                "message": "요청이 성공했습니다.",
                "result": {
                    "placeVisitId": 10,
                    "liked": true
                    }
            }
            """
            return json.data(using: .utf8)!
            
        case .getVisitedDateList:
            
            return """
            {
              "isSuccess": true,
              "code": "string",
              "message": "string",
              "result": {
                "visitedDate": [
                  "2025-02-01",
                  "2025-02-02",
                  "2025-02-03",
                  "2025-02-04",
                  "2025-02-05",
                  "2025-02-06",
                  "2025-02-07"
                ]
              }
            }
            """.data(using: .utf8)!
        }
        

    }

}

// MARK: - Extension
extension PlaceAPITarget {
    
    /// 장소 평점/리뷰 달기 API
    /// - Parameters:
    ///   - reviewRequest: Request 모델
    ///   - reviewImages: 업로드한 리뷰 이미지 배열
    /// - Returns: 멀티파트폼 데이터
    private func encodeReviewData(reviewRequest: PlaceReviewSubmissionRequest, reviewImages: [UIImage]) -> [MultipartFormData] {
        
        var formData: [MultipartFormData] = []
        
        if let ratingData = String(reviewRequest.rating).data(using: .utf8),
           let commentData = String(reviewRequest.comment).data(using: .utf8),
           let visitedDate = String(reviewRequest.visitedDate).data(using:. utf8)
        {
            let ratingFormData = MultipartFormData(provider: .data(ratingData), name: "rating")
            let commentFormData = MultipartFormData(provider: .data(commentData), name: "comment")
            let visitedDateFormData = MultipartFormData(provider: .data(visitedDate), name: "visitedDate")
            
            formData.append(ratingFormData)
            formData.append(commentFormData)
            formData.append(visitedDateFormData)
        }
        
        for (index, reviewImage) in reviewImages.enumerated() {
            
            if let image = reviewImage.jpegData(compressionQuality: 0.8) {

                let multipartData = MultipartFormData(provider: .data(image), name: "images", fileName: "images\(index).jpg", mimeType: "images/jpeg")
                formData.append(multipartData)
            }
        }
        
        
        return formData
    }
}
