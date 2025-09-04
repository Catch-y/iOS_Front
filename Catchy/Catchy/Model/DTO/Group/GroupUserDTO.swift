//
//  GroupUserDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 사용자가 속한 그룹 조회
struct GroupUserQuery: Codable {
    let year: Int
    let month: Int
}

struct GroupUserResponse: Codable, Identifiable {
    var id: UUID = .init()
    let groupId: Int
    let groupName: String
    let promiseTime: String
    
    enum CodingKeys: CodingKey {
        case groupId
        case groupName
        case promiseTime
    }
}
