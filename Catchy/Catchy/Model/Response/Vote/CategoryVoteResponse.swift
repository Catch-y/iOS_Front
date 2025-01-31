//
//  PostCategoryVoteResponse.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//


import Foundation

/// 카테고리 투표 응답 모델
struct CategoryVoteResponse: Codable {
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case success = "success"
    }
}

