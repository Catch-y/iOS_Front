//
//  GroupGenerate.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 그룹 생성
struct GroupGenerateRequest: Codable {
    let groupName: String
    let groupLocation: String
    let promiseTime: String
    let inviteCode: String
}

struct GroupGenerateResponse: Codable {
    let groupId: Int
    let groupName: String
    let groupLocation: String
    let groupImage: String
    let inviteCode: String
    let promiseTime: String
    let creatorNickname: String
}
