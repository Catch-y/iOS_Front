//
//  VoteInProgressDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 투표 진행 중
/// 해당 카테고리 ID 목록 조회
struct VoteInProgressPath: Codable {
    let voteId: Int
}

struct VoteInProgressResponse: Codable {
    let voteId: Int
    let categories: [VoteCategoryData]
}

struct VoteCategoryData: Codable, Identifiable {
    var id: UUID = .init()
    let categoryId: Int
    let name: CategoryType
}
