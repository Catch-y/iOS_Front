//
//  CourseRecommendDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 홈화면 추천 코스
struct CourseRecommendResponse: Codable {
    let courseId: Int
    let courseName: String
    let courseDescription: String
    let courseImage: String
    let courseType: CourseType
}
