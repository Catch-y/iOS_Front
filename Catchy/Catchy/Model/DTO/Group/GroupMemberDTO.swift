//
//  GroupMemberDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 그룹 유저 조회
struct GroupMemberPath: Codable {
    let groupId: Int
}

struct GroupMemberResponse: Codable, Identifiable {
    var id: UUID = .init()
    let memberId: Int
    let nickname: String
    let profileImage: String
    
    enum CodingKeys: CodingKey {
        case memberId
        case nickname
        case profileImage
    }
}
