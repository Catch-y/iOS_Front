//
//  VoteResultPlaceResponse.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation

struct VoteResultPlaceResponse: Codable {
    let groupLocation: String
    let places: [PlaceResponse]
}

struct PlaceResponse: Codable {
    let placeId: Int
    let placeName: String
    let roadAddress: String
    let rating: Double
    let reviewCount: Int
    let imageUrl: String
    let votedMembers: [VotedMemberResponse]
}

struct VotedMemberResponse: Codable {
    let memberId: Int
    let nickname: String
    let profileImage: String
}

