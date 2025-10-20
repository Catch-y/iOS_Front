//
//  MemberReIssueDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 토큰 재발급
struct MemberReIssueResponse: Codable {
    var accessToken: String
    var refreshToken: String
}
