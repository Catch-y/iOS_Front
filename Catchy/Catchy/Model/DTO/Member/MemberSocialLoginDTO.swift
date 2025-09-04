//
//  MemberSocialLoginDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

struct MemberSocialLoginRequest: Codable {
    let accessToken: String
}

struct MemberSocialLoginResponse: Codable {
    let id: Int
    let providerId: String
    let email: String
    let nickname: String
    let createdDate: String
    let accessToken: String
    let refreshToken: String
}
