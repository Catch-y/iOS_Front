//
//  VoteGenerateDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 투표 생성
struct VoteGenerateRquest: Codable {
    let groupId: Int
}

/// 투표 생성
struct VoteGenerateResponse: Codable {
    let voteId: Int
}
