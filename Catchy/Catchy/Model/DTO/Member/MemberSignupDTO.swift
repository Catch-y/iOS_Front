//
//  MemberSignupDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 소셜 회원가입
struct MemberSignupRequest: Codable {
    let accessToken: String
    let authorizationCode: String
    let nickname: String
}

struct MemberSIgnupResponse: Codable {
    let id: Int
    let providerId: String
    let email: String
    let nickname: String
    let profileImage: String
    let createdDate: String
    let accessToken: String
    let refreshToken: String
    let fcmInfo: FCMSignupInfo
}

struct FCMSignupInfo: Codable {
    let fcmToken: String
    let appAlarm: Bool
}
