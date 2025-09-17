//
//  VoteLocationToggle.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 장소 투표/취소
struct VoteLocationTogglePath: Codable {
    let groupId: Int
    let voteId: Int
}

struct VoteLocationToggleRequet: Codable {
    let placeId: Int
}
