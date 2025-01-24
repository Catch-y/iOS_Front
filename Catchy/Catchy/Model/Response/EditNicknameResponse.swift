//
//  EditNicknameResponse.swift
//  Catchy
//
//  Created by LEE on 1/23/25.
//

import Foundation

/// 닉네임 수정 리스폰스 바디
/// request body가 2개 이상이면 모델을 만들어라
struct EditNicknameResponse: Codable {
    
    let id: Int
    let email: String
    let nickname: String
    let profileImage: String
    let SocialType: String
    
}
