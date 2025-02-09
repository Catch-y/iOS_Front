//
//  PlaceVoteRequest.swift
//  Catchy
//
//  Created by 임소은 on 2/3/25.
//

import Foundation

// 투표 장소
struct PlaceVoteRequest: Codable {
    let placeId: Int
    let isVoted: Bool
}
