//
//  ReviewCourseDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

struct ReviewMyCourseRequest: Codable {
    let pageSize: Int
    let lastReviewId: Int
}
