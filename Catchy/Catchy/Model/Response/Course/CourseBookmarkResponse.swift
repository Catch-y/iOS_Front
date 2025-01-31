//
//  CourseBookmarkResponse.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation

/// 코스 북마크 API
struct CourseBookmarkResponse: Codable {
    
    /// 멤버 코스 ID
    let memberCourseId: Int
    
    /// 코스 북마크 했는지?
    let bookmarked: Bool
}
