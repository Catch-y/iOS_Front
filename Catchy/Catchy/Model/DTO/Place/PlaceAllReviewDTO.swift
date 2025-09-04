//
//  PlaceAllReviewDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 장소 리뷰 전체 조회
struct PlaceAllReviewPath: Codable {
    let placeId: Int
}
struct PlaceAllReviewQuery: Codable {
    let pageSize: Int
    let lastPlaceReviewDate: String?
    let lastPlaceReviewId: String?
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
    
    struct Review: Codable, Identifiable {
        var id: UUID = .init()
        let reviewId: Int
        let comment: String
        let rating: Int
        let reviewImages: [ReviewImage]
        let visitedDate: String
        let creatorNickname: String
        
        enum CodingKeys: CodingKey {
            case reviewId
            case comment
            case rating
            case reviewImages
            case visitedDate
            case creatorNickname
        }
    }
}
