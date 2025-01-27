//
//  EditNicknameResponse.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation

/// 닉네임 수정 리스폰스 바디
struct EditNicknameResponse: Codable {
    let id: Int
    let email: String
    let nickname: String
    let profileImage: String
    let SocialType: String
}
