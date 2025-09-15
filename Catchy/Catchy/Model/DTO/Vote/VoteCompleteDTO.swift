//
//  VoteCompleteDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 투표 완료 - 카테고리 확인
struct VoteCompletePath: Codable {
    let groupId: Int
    let voteId: Int
}

struct VoteCompleteResponse: Codable {
    let groupLocation: String
    let categories: [CategoryData]
}

struct CategoryData: Codable, Identifiable {
    var id: UUID = .init()
    let category: CategoryType
    let count: Int
    
    enum CodingKeys: CodingKey {
        case category
        case count
    }
}
