//
//  PlaceAllReviewDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 장소 리뷰 전체 조회
struct PlaceAllReviewRequest: Codable {
    let pageSize: Int
    let lastPlaceReviewDate: String
    let lastPlaceReviewId: String
}

struct PalceAllReviewResponse: Codable {
    let averageRating: Double
    let ratingList: [Rating]
    let totalCount: Int
    let content: [Review]
    let last: Bool
    
    struct Rating: Codable {
        let score: Int
        let count: Int
    }
    
    struct Review: Codable {
        let reviewId: Int
        let comment: String
        let rating: Int
        let reviewImages: [ReviewImage]
        let visitedDate: String
        let creatorNickname: String
    }
}
