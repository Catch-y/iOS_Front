//
//  CourseCategory.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 장소 카테고리 선택
struct CourseCategoryRequest: Codable {
    let bigCategory: String
    let smallCategory: String
}
