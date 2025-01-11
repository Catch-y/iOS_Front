//
//  TokenResponse.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation

struct TokenResponse: Codable {
    var accessToken: String
    var refreshToken: String
}
