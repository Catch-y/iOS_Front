//
//  GroupJoinDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 그룹 초대 코드로 가입
struct GroupJoinRequest: Codable {
    let inviteCode: String
}

struct GroupJoinResponse: Codable {
    let success: Bool
    let message: String
}
