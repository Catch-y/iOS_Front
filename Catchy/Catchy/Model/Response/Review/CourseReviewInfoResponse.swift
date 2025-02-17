//
//  CourseReviewInfoResponse.swift
//  Catchy
//
//  Created by 권용빈 on 2/17/25.
//

import Foundation

struct CourseReviewInfoResponse: Codable {
    /// 전체 코스 평균 평점
    let courseRating: Double
    
    /// 전체 리뷰 수
    let totalCount: Int
    
    /// 리뷰 내용
    let content: [CourseReviewContents]
    
    /// 마지막 요소인지 아닌지
    let last: Bool
}

struct CourseReviewContents: Codable, Hashable {
    
    /// 리뷰 ID
    let reviewId: Int
    
    /// 리뷰 내용
    let comment: String
    
    /// 리뷰 이미지
    let reviewImages: [ReviewImageData]
    
    /// 방문일
    let createdAt: String
    
    /// 작성자 닉네임
    let creatorNickname: String
}
