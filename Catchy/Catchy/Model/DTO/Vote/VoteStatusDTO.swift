//
//  VoteStatusDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 투표 진행 중
struct VoteStatusResponse: Codable, Identifiable {
    var id: UUID = .init()
    let category: CategoryType
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

struct VotedMember: Codable {
    let memberId: Int
    let nickname: String
    let profileImage: String
    
    enum CodingKeys: CodingKey {
        case memberId
        case nickname
        case profileImage
    }
}

