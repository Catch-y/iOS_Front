//
//  PlaceCourseSearchDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 지역명 기반 장소 검색
struct PlaceCourseSearchResponse: Codable {
    let placeInfoPreviews: [PlaceInfoPreview]
    let isLast: Bool
}

struct PlaceInfoPreview: Codable, Identifiable {
    var id: UUID = .init()
    let placeId: Int
    let placeName: String
    let placeImage: String
    let category: CategoryType
    let roadAddress: String
    let activeTime: String
    let rating: Double
    let placeLatitude: Double
    let placeLongitude: Double
    let reviewCount: Int
    let liked: Bool
    
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
