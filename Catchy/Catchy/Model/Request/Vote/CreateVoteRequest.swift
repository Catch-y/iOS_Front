//
//  CreateVoteRequest.swift
//  Catchy
//
//  Created by 임소은 on 1/31/25.
//

import Foundation


/// 투표 생성 요청 모델
struct CreateVoteRequest: Codable {
    let groupId: Int  // 그룹 ID

    enum CodingKeys: String, CodingKey {
        case groupId = "groupId"
    }
}
