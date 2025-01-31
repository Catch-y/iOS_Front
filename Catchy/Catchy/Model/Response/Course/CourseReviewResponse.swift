//
//  CourseReviewResponse.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation

struct CourseReviewResponse: Codable {
    
    /// 리뷰 ID
    let reviewId: Int
    
    /// 리뷰 내용
    let comment: String
    
    /// 리뷰 이미지 데이터 배열
    let reviewImages: [CourseReviewResponseImageData]
}


struct CourseReviewResponseImageData: Codable {
    
    /// 리뷰 이미지 ID
    let reviewImageId: Int
    
    /// 리뷰 이미지 URL
    let imageUrl: String
}
