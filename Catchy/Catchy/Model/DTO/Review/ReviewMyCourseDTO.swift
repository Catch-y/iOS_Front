//
//  ReviewCourseDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 마이페이지 내 코스 리뷰 조회
struct ReviewMyCourseQuery: Codable {
    let pageSize: Int
    let lastReviewId: Int?
}
struct ReviewMyCourseRequest: Codable {
    let pageSize: Int
    let lastReviewId: Int
}
