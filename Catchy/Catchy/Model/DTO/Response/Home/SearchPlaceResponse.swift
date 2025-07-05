//
//  SearchPlaceResponse.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import Foundation

struct SearchPlaceResponse: Codable {
    var placeInfoPreviews: [PlaceInfoDataAndScore]
    var isLast: Bool
    
    enum CodingKeys: String, CodingKey {
            case placeInfoPreviews = "content"
            case isLast = "last"
    }
    
}

struct PlaceInfoDataAndScore: Codable {
    var placeInfoResponse: SearchPlaceData
    var relevanceScore: Int
}

struct SearchPlaceData: Codable, Identifiable, Hashable {
    var id = UUID()
    var placeId: Int
    var placeName: String
    var placeImage: String
    var categoryName: CategoryType?
    var roadAddress: String
    var activeTime: String?
    var rating: Double
    var reviewCount: Int
    
    enum CodingKeys: String, CodingKey {
        case placeId
        case placeName
        case placeImage = "imageUrl"
        case categoryName = "categoryName"
        case roadAddress
        case activeTime
        case rating
        case reviewCount
    }
}
