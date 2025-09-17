//
//  MemberNicknameCheckDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 닉네임 중복 검사
struct MemberNicknameCheckRequest: Codable {
    let nickname: String
}
