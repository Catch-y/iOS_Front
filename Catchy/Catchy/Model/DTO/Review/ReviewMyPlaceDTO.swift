//
//  ReviewMyPlaceDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 마이페이지 / 내 장소 리뷰 조회
struct ReviewMyPlaceQuery: Codable {
    let pageSize: Int
    let lastPlaceReviewDate: String?
    let lastReviewId: Int?
}

struct ReviewMyPlaceResponse: Codable {
    let reviewType: ReviewType
    let reviewCount: Int
    let content: [Content]
    let last: Bool
    
    struct Content: Codable {
        let reviewId: Int
        let name: String
        let comment: String
        let reviewImages: [ReviewImage]
    }
}
