//
//  VoteCategory.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 카테고리 투표 + 카테고리 재투표
struct VoteCategoryPath: Codable {
    let voteId: Int
}
struct VoteCategoryRequest: Codable {
    let categoryIds: [Int]
}
