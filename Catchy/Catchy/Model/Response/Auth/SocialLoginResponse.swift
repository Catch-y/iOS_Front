//
//  SocialLoginResponse.swift
//  Catchy
//
//  Created by 정의찬 on 1/22/25.
//

import Foundation

struct SocialLoginResponse: Codable {
    let id: Int
    let providerId: String
    let email: String
    let nickname: String
    let createdDate: String
    let accessToken: String
    let refreshToken: String
}
