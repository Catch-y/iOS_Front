//
//  CreateGroupRespones.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//
import Foundation

struct CreateGroupResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: GroupResult?
    
}

struct GroupResult: Codable {
    let groupId: Int
    let groupName: String
    let groupLocation: String
    let groupImage: String?
    let inviteCode: String
    let promiseTime: String
    let creatorNickname: String
}
