//
//  MemberLocationDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 사용자 취향설문 선호지역
struct MemberLocationRequest: Codable {
    let upperLocation: String
    let lowerLocation: String
}

struct MemberLocationResponse: Codable {
    let memberLocationId: [Int]
}
