//
//  CreateGroupRequest.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation

/// [그룹 생성] Request 모델
struct CreateGroupRequest: Codable {
    let groupName: String
    let groupLocation: String
    let promiseTime: String
    let inviteCode: String
    let groupImage: Data?
}
