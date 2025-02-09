//
//  VoteCategoryResponse.swift
//  Catchy
//
//  Created by 임소은 on 2/8/25.
//

import Foundation

// 전체 응답을 나타내는 구조체
struct VoteCategoryResponse: Codable {
    let categories: [CategoryDto]

    struct CategoryDto: Identifiable, Codable {
        var id: Int { return categoryId }
        let categoryId: Int
        let name: String
    }
}
