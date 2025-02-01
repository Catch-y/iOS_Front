//
//  CreateGroupResponest.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation

/// [그룹 생성] Response 모델
struct CreateGroupResponse: Codable {
    let groupId: Int
    let groupName: String
    let groupLocation: String
    let groupImage: String
    let inviteCode: String
    let promiseTime: String
    let creatorNickname: String
}
