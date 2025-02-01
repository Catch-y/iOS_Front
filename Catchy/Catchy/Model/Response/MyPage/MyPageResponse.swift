//
//  MyPageResponse.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import Foundation

/// 사용자 프로필 response
struct UserProfile: Codable {
    
    /// 사용자 고유 id
    let id: Int
    
    /// 사용자 닉네임
    let nickname: String
    
    /// 사용자 프로필 사진
    let profileImage: String
}
