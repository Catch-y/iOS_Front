//
//  CategoryVoteRequest.swift
//  Catchy
//
//  Created by 임소은 on 2/7/25.
//

import Foundation

struct VoteCategoryRequest: Codable {
    let voteId: Int  // voteId는 URL 파라미터로 전달되므로 모델에 포함
}
