//
//  VoteResponse.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation

struct VoteResponse: Codable {
    /// 투표 멤버 목록
    let members: [MemberResponseData]
    
    /// 총 멤버 수
    let totalMembers: Int
}

struct MemberResponseData: Codable, Identifiable {
    /// 멤버 ID (Identifiable 프로토콜 구현)
    var id: Int { memberId }
    
    /// 투표 ID
    let voteId: Int
    
    /// 멤버 ID
    let memberId: Int
    
    /// 멤버 프로필 이미지
    let profileImage: String
    
    /// 투표 여부
    let hasVoted: Bool
    
    /// CodingKeys 정의
    enum CodingKeys: String, CodingKey {
        case voteId
        case memberId
        case profileImage
        case hasVoted
    }
}

