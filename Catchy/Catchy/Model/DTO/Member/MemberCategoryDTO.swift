//
//  MemberSurveyCategory.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 사용자 취향설문 카테고리
struct MemberCategoryRequest: Codable {
    let categories: [CategoryType]
}

struct MemberCategoryResponse: Codable {
    let memberCategoryIds: [Int]
}
