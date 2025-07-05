//
//  VoteInProgressResponse.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation

/// [투표 진행 중] Response 모델
struct VoteInProgressResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: VoteInProgressResult
}

/// [투표 진행 중] 결과 데이터
struct VoteInProgressResult: Codable {
    let status: String
    let totalMembers: Int
    let results: [VoteResult]
}

/// 투표 결과 데이터
struct VoteResult: Codable {
    let category: String
    let voteCount: Int
    let votedMembers: [VotedMember]
    let rank: Int
}

/// 투표한 멤버 데이터
struct VotedMember: Codable {
    let memberId: Int
    let nickname: String
    let profileImage: String
}

