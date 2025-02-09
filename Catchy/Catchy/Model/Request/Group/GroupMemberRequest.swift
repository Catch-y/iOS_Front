//
//  GroupMembersRequest.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation

/// [그룹 유저 조회] Request 모델
struct GroupMembersRequest: Codable {
    let groupId: Int

    /// CodingKeys 정의 (필요시 사용 가능)
    enum CodingKeys: String, CodingKey {
        case groupId
    }
}
