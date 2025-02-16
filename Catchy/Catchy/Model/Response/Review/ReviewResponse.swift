//
//  ReviewResponse.swift
//  Catchy
//
//  Created by 권용빈 on 1/22/25.
//

import Foundation

struct ReviewResponse: Codable {
    
    /// 전체 평균 평점
    let totalRating: Double
    
    /// 평점 별 리뷰 수
    let reviewCount: [ScoreCount]
    
    /// 전체 리뷰 수
    let totalCount: Int
    
    /// 리뷰 내용
    let content: [ReviewContents]
    
    /// 마지막 요소인지 아닌지
    let last: Bool
}

struct ScoreCount: Codable {
    
    /// 별점
    let score: Int
    
    /// 개수
    let count: Int
}

struct ReviewContents: Codable, Hashable {
    let reviewId: Int
    let comment: String
    let rating: Int
    let reviewImages: [ReviewImageData]
    let creatorNickname: String
    let visitedDate: String
}

/// 리뷰 이미지 데이터를 담는 구조체
struct ReviewImageData: Codable, Hashable {
    
    /// 리뷰 이미지 ID
    let reviewImageId: Int
    
    /// 이미지 URL
    let imageUrl: String
}
