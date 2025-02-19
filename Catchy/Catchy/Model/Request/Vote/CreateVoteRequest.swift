//
//  CreateVoteRequest.swift
//  Catchy
//
//  Created by 임소은 on 2/14/25.
//

import Foundation

/// 투표 생성 Request DTO
struct CreateVoteRequest: Codable {
    /// 그룹 ID
    let groupId: Int

    /// CodingKeys 추가
    enum CodingKeys: String, CodingKey {
        case groupId = "groupId"
    }
}
