//
//  PlaceCourseLikeDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 좋아요한 장소 무한 스크롤
struct PlaceCourseLikeResponse: Codable {
    let content: [LikePlaceData]
    let last: Bool
}

struct LikePlaceData: Codable, Identifiable {
    var id: UUID = .init()
    let placeId: Int
    let imageUrl: String
    let placeName: String
    let categoryName: String
    let roadAddress: String
    let activeTime: String
    let rating: Double
    let reviewCount: Int
    
    enum CodingKeys: CodingKey {
        case placeId
        case imageUrl
        case placeName
        case categoryName
        case roadAddress
        case activeTime
        case rating
        case reviewCount
    }
}
