//
//  CategoryVoteRequest.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation

/// 카테고리 투표 요청 모델
struct CategoryVoteRequest: Codable {
    let categoryIds: [Int] // ✅ categoryIds만 포함!

    enum CodingKeys: String, CodingKey {
        case categoryIds = "categoryIds"
    }
}

