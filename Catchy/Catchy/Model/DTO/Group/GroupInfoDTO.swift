//
//  GroupInfoDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 초대 코드로 그룹 정보 조회
struct GroupInfoPath: Codable {
    let inviteCode: String
}

struct GroupInfoResponse: Codable {
    let groupName: String
    let groupLocation: String
    let promiseTime: String
    let groupImage: String
}
