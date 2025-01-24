//
//  GetCourseInfoRequest.swift
//  Catchy
//
//  Created by LEE on 1/23/25.
//

import Foundation

struct GetCourseInfoRequest: Codable {
    let type: CourseType
    let upperLocation: String
    let lowerLocation: String
    let lastId: Int
}
