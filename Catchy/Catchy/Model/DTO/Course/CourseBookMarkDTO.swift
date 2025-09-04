//
//  CourseBookmarkDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 코스 북마크
struct CourseBookMarkRequest: Codable {
    let memberCourseId: Int
    let bookmarked: Bool
}
