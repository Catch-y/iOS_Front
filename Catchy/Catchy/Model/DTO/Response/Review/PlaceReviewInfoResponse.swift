//
//  ReviewResponse.swift
//  Catchy
//
//  Created by 권용빈 on 1/22/25.
//

import Foundation

struct PlaceReviewInfoResponse: Codable {
    
    /// 전체 평균 평점
    let averageRating: Double
    
    /// 평점 별 리뷰 수
    let ratingList: [ScoreCount]
    
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

struct ReviewContents: Codable, Identifiable {
    
    var id = UUID()
    
    /// 리뷰 ID
    let reviewId: Int
    
    /// 리뷰 내용
    let comment: String
    
    /// 별점
    let rating: Int
    
    /// 리뷰 이미지
    let reviewImages: [ReviewImageData]
    
    /// 방문일
    let visitedDate: String
    
    /// 작성자 닉네임
    let creatorNickname: String
    
    enum CodingKeys: String, CodingKey {
        case reviewId
        case comment
        case rating
        case reviewImages
        case visitedDate
        case creatorNickname
    }
}

/// 리뷰 이미지 데이터를 담는 구조체
struct ReviewImageData: Codable, Hashable {
    
    /// 리뷰 이미지 ID
    let reviewImageId: Int
    
    /// 이미지 URL
    let imageUrl: String
}
