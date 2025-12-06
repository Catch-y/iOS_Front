//
//  PlaceSearchDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 장소 검색
struct PlaceSearchQuery: Codable {
    let keyword: String?
    let pageSize: Int
    let relevanceScore: Int?
    let lastPlaceId: Int?
}

struct PlaceSearchResponse: Codable {
    let content: [PlaceSearchContent]
    let last: Bool
}

struct PlaceSearchContent: Codable, Identifiable {
    var id: UUID = .init()
    let placeInfoResponse: PlaceInfoResponse
    let relevanceScore: Int
    
    enum CodingKeys: CodingKey {
        case placeInfoResponse
        case relevanceScore
    }
    
    struct PlaceInfoResponse: Codable, Identifiable {
        var id: UUID = .init()
        let placeId: Int
        let imageUrl: String
        let placeName: String
        let categoryName: CategoryType
        let roadAddress: String
        let activeTime: String?
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
}


