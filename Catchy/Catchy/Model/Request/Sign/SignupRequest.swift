//
//  SwiftAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation

struct SignupRequest: Codable {
    let accessToken: String
    let authorizationCode: String?
    let nickname: String
}
