//
//  GetCourseRequest.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation

struct GetCourseRequest: Codable {
    let type: CourseType
    let upperLocation: String
    let lowerLocation: String
    let lastId: Int
}
