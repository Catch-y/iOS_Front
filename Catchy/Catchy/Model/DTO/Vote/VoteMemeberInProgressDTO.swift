//
//  VoteCategoryMemberDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 투표 진행 중 멤버별 확인
struct VoteMemeberInProgressResponse: Codable {
    let totalMembers: Int
    let members: [MemberData]
}

struct MemberData: Codable, Identifiable {
    var id: UUID = .init()
    let memberId: Int
    let nickname: String
    let profileImage: String
    let hasVoted: Bool
    
    enum CodingKeys: CodingKey {
        case memberId
        case nickname
        case profileImage
        case hasVoted
    }
}
