//
//  SearchPlaceResponse.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import Foundation

struct SearchPlaceResponse: Codable, Hashable {
    var content: [SearchPlaceData]
}

struct SearchPlaceData: Codable, Identifiable, Hashable {
    var id = UUID()
    var placeId: Int
    var searchedPlaceName: String
    var searchedPlaceCategory: CategoryType
    var placeName: String
    var placeImageUrl: String
    var roadAddress: String
    var activeTime: String
    var reviewCount: Int
    var averageRating: Double
    
    enum CodingKeys: CodingKey {
        case placeId
        case searchedPlaceName
        case searchedPlaceCategory
        case placeName
        case placeImageUrl
        case roadAddress
        case activeTime
        case reviewCount
        case averageRating
    }
}
