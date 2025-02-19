//
//  CreatVoteResponse.swift
//  Catchy
//
//  Created by 임소은 on 1/31/25.
//

import Foundation


/// 투표 생성 응답 모델
struct CreateVoteResponse: Codable {
    let voteId: Int  // 생성된 투표 ID

    enum CodingKeys: String, CodingKey {
        case voteId = "voteId"
    }
}
