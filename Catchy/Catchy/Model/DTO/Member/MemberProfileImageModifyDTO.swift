//
//  MemberProfileImageModifyDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

struct MemberProfileImageModifyRequest: Codable {
    let profileImage: Data
}

struct MemeberProfileImageModifyResponse: Codable {
    let id: Int
    let profileImage: String
}
