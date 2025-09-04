//
//  VoteCategoryPlace.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 투표 완료 - 카테고리 별 장소 확인
struct VoteCategoryPlaceRequest: Codable {
    let groupdId: Int
    let category: CategoryType
}

struct VoteCategoryPlaceResponse: Codable {
    let groupLocation: String
    let places: [PlaceData]
    let isLast: Bool
}

struct PlaceData: Codable, Identifiable {
    var id: UUID = .init()
    let placeId: Int
    let placeName: String
    let roadAddress: String
    let rating: Int
    let reviewCount: Int
    let imageUrl: String
    let votedMembers: [VotedMember]
    
    enum CodingKeys: CodingKey {
        case placeId
        case placeName
        case roadAddress
        case rating
        case reviewCount
        case imageUrl
        case votedMembers
    }
}
