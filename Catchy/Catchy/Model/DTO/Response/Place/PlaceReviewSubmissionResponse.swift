//
//  PlaceReviewSubmissionResponse.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import Foundation

/// 장소 평점/리뷰 달기 API
struct PlaceReviewSubmissionResponse: Codable {
    
    /// 리뷰 ID
    let reviewId: Int
    
    /// 장소 평점
    let rating: Int
    
    /// 리뷰 내용
    let comment: String
    
    /// 리뷰 이미지 목록
    let reviewImages: [ReviewImageResponse]
    
    /// 방문 날짜
    let visitedDate: String
    
    /// 작성자 닉네임
    let creatorNickname: String
}

/// 리뷰 이미지 정보
struct ReviewImageResponse: Codable {
    
    /// 이미지 ID
    let reviewImageId: Int
    
    /// 이미지 URL
    let imageUrl: String
}
