//
//  VoteCategoryRequest.swift
//  Catchy
//
//  Created by 임소은 on 2/14/25.
//

import Foundation

/// 카테고리 투표 Request DTO
struct VoteCategoryRequest: Codable {
    let categories: [String]
}
