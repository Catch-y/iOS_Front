//
//  SearchPlaceResponse.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import Foundation

struct SearchPlaceResponse: Codable, Hashable {
    var placeInfoPreviews: [SearchPlaceData]
    var isLast: Bool
}

struct SearchPlaceData: Codable, Identifiable, Hashable, Likeable {
    var id = UUID()
    var placeId: Int
    var placeName: String
    var placeImage: String
    var categoryName: CategoryType?
    var roadAddress: String
    var activeTime: String?
    var rating: Double
    var reviewCount: Int
    var liked: Bool
    
    enum CodingKeys: String, CodingKey {
        case placeId
        case placeName
        case placeImage
        case categoryName
        case roadAddress
        case activeTime
        case rating
        case reviewCount
        case liked
    }
}
