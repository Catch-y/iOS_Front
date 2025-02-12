//
//  RecommendPlaceResponse.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import Foundation

struct RecommendPlaceResponse: Codable {
    let content: [RecommendPlaceResponseData]
}

struct RecommendPlaceResponseData: Codable, Identifiable, Likeable {
    var id = UUID()
    let placeId: Int
    let placeName: String
    let placeImage: String
    let category: String
    let roadAddress: String
    let activeTime: String?
    let rating: Double
    let reviewCount: Int
    var liked: Bool
}
