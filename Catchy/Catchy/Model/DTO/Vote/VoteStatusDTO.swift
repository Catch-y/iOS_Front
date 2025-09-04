//
//  VoteStatusDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 투표 진행 중
/// 카테고리 투표 진행 중 투표 현황 조회
struct VoteStatusPath: Codable {
    let voteId: Int
}

struct VoteStatusResponse: Codable {
    let status: String
    let totalMembers: Int
    let results: [VoteResult]
}

struct VoteResult: Codable, Identifiable {
    var id: UUID = .init()
    let category: String
    let voteCount: Int
    let votedMembers: [VotedMember]
    let rank: Int
    
    enum CodingKeys: CodingKey {
        case category
        case voteCount
        case votedMembers
        case rank
    }
}

struct VotedMember: Codable, Identifiable {
    var id: UUID = .init()
    let memberId: Int
    let nickname: String
    let profileImage: String
    
    enum CodingKeys: CodingKey {
        case memberId
        case nickname
        case profileImage
    }
}
