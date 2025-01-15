//
//  CourseInfoResponse.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import Foundation

struct CourseInfoResponse: Codable, Identifiable {
    var courseId = UUID()
    let id: Int
    let courseType: CourseType
    let courseImage: String
    let courseName: String
    let courseDescription: String
    let categories: [CategoryType]
}
