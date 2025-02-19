//
//  VoteCategoryRevoteRequest.swift
//  Catchy
//
//  Created by 임소은 on 2/14/25.
//

import Foundation

/// 카테고리 재투표 Request DTO
struct VoteCategoryRevoteRequest: Codable {
    /// 선택한 카테고리 ID 목록
    let categoryIds: [Int]

    /// CodingKeys 추가
    enum CodingKeys: String, CodingKey {
        case categoryIds = "categoryIds"
    }
}
