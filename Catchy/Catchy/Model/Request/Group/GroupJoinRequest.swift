//
//  GroupJoinRequest.swift
//  Catchy
//
//  Created by 임소은 on 2/14/25.
//

import Foundation

/// 그룹 초대 코드 가입 Request DTO
struct GroupJoinRequest: Codable {
    /// 그룹 초대 코드
    let inviteCode: String

    /// CodingKeys 추가
    enum CodingKeys: String, CodingKey {
        case inviteCode = "inviteCode"
    }
}
