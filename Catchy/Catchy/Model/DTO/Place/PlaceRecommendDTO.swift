//
//  PlaceRecommendDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 사용자 장소 추천
struct PlaceRecommendQuery: Codable {
    let latitude: Double
    let longitude: Double
    let pageSize: Int
    let page: Int
}

struct PlaceRecommendResponse: Codable {
    let content: [PlaceRecommendContentDTO]
    let isLast: Bool
}

struct PlaceRecommendContentDTO: Codable, Identifiable, Likeable {
    var id: UUID = .init()
    let placeId: Int
    let placeName: String
    let placeImage: String
    let category: String
    let roadAddress: String
    let activeTime: String?
    let rating: Double
    let placeLatitude: Double
    let placeLongitude: Double
    let reviewCount: Int
    var liked: Bool
    
    enum CodingKeys: CodingKey {
        case placeId
        case placeName
        case placeImage
        case category
        case roadAddress
        case activeTime
        case rating
        case placeLatitude
        case placeLongitude
        case reviewCount
        case liked
    }
}
