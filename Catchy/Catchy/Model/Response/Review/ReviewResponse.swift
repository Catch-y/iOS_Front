//
//  ReviewResponse.swift
//  Catchy
//
//  Created by 권용빈 on 1/22/25.
//

import Foundation

struct ReviewResponse: Codable {
    let totalRating: Double
    let reviewCount: [ScoreCount]
    let totalCount: Int
    let content: [ReviewContents]
    let last: Bool
}

struct ScoreCount: Codable {
    let score: Int
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


struct ReviewImageData: Codable, Hashable {
    let reviewImageId: Int
    let imageUrl: String
}
