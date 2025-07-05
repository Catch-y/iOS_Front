//
//  BaseResponseVoteMemberListResponse.swift
//  Catchy
//
//  Created by 임소은 on 2/14/25.
//

import Foundation

/// [투표 진행 중 멤버 상태] Response DTO
struct VoteMemberResponse: Codable {
    let memberId: Int
    let nickname: String
    let profileImage: String
    let hasVoted: Bool
}

/// [Base Response] - 투표 진행 중 멤버 상태 조회 응답
struct BaseResponseVoteMemberListResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [VoteMemberResponse]  
}


