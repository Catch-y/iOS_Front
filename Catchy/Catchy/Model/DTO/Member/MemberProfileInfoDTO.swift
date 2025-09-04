//
//  MemberProfileInfoDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 프로필 조회
struct MemberProfileInfoResponse: Codable {
    let id: Int
    let profileImage: String
    let nickname: String
}
