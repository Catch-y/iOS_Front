//
//  VoteInProgressDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 투표 진행 중
struct VoteInProgressResponse: Codable {
    let voteId: Int
    let categories: [VoteCategoryData]
}

struct VoteCategoryData: Codable {
    let categoryId: Int
    let name: CategoryType
}
