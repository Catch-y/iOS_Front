//
//  VoteResultCategoryResponse.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation

struct VoteResultCategoryResponse: Codable {
    let groupLocation: String
    let categories: [CategoryResultData]
}

struct CategoryResultData: Codable {
    let category: String
    let count: Int
}
