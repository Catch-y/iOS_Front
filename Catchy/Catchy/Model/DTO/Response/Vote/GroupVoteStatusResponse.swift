//
//  GroupVoteStatusResponse.swift
//  Catchy
//
//  Created by 임소은 on 2/14/25.
//

import Foundation

/// [투표 진행 중 멤버 상태] Response DTO
struct MemberVoteStatus: Codable {
    let memberId: Int
    let nickname: String
    let hasVoted: Bool
}

/// [그룹 내 투표 상태 응답] Response DTO
struct GroupVoteStatusResponse: Codable {
    let totalMembers: Int
    let members: [MemberVoteStatus]
}

/// [Base Response] - 투표 진행 중 멤버 상태 조회 응답
struct BaseResponseGroupVoteStatusResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: GroupVoteStatusResponse
}
