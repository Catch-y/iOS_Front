//
//  PlaceReviewDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 장소 평점/리뷰 달기
struct PlaceReviewRequest: Codable {
    let rating: Double
    let comment: String
    let visitedDate: String
    let images: [Data]
}

struct PlaceReviewResponse: Codable {
    let reviewId: Int
    let comment: String
    let rating: Double
    let reviewImages: [ReviewImage]
    let visitedDate: String
    let creatorNickname: String
}


struct ReviewImage: Codable, Identifiable {
    var id: UUID = .init()
    let reviewImageId: Int
    let imageUrl: String
    
    enum CodingKeys: CodingKey {
        case reviewImageId
        case imageUrl
    }
}
