//
//  RecommendPlaceResponse.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import Foundation

struct RecommendPlaceResponse: Codable, Identifiable {
    let id = UUID()
    let placeId: Int
    let placeImageUrl: String
    let category: String
    let placeName: String
    let roadAddress: String
    let activeTime: String
    let reviewCount: Int
    let averageRating: Double
    var isLike: Bool
    
    enum CodingKeys: CodingKey {
        case placeId
        case placeImageUrl
        case category
        case placeName
        case roadAddress
        case activeTime
        case reviewCount
        case averageRating
        case isLike
    }
}
