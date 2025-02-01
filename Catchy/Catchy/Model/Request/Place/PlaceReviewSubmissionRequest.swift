//
//  PlaceReviewSubmissionRequest.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import Foundation

/// 장소 평점/리뷰 달기 API
struct PlaceReviewSubmissionRequest: Codable {
    
    /// 장소 ID
    let placeId: Int
    
    /// 장소 평점
    let rating: Int
    
    /// 리뷰 내용
    let comment: String
    
    // 리뷰 이미지 목록
    let reviewImages: [ReviewImageRequest]
}

/// 리뷰 이미지 정보
struct ReviewImageRequest: Codable {
    
    /// 이미지 ID
    let reviewImageId: Int
    
    /// 이미지 URL
    let imageUrl: String
}
