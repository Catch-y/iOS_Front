//
//  GroupInfo.swift
//  Catchy
//
//  Created by 임소은 on 2/18/25.
//

import Foundation

struct GroupInfo: Codable {
    let groupId: Int? // 서버에서 받은 그룹 ID
    let groupName: String
    let groupLocation: String
    let promiseTime: String
    let inviteCode: String? // 서버에서 받아온 초대 코드
    let groupImage: String?

    init(groupId: Int? = nil, groupName: String, groupLocation: String, promiseTime: String, groupImage: String?, inviteCode: String? = nil) {
        self.groupId = groupId // 서버에서 받아온 그룹 ID
        self.groupName = groupName
        self.groupLocation = groupLocation
        self.promiseTime = promiseTime
        self.groupImage = groupImage
        self.inviteCode = inviteCode // 서버에서 받아온 초대 코드로 설정
    }
}
