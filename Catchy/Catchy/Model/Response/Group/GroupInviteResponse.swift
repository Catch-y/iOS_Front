//
//  GroupInviteResponse.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation

/// [초대 코드로 그룹 정보 조회] Response 모델
struct GroupInviteResult: Codable {
    let groupName: String
    let groupLocation: String
    let promiseTime: String
    let groupImage: String
}

struct BaseResponseGroupInviteResult: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: GroupInviteResult
}
