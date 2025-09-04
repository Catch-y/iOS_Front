//
//  CourseModifyDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 코스 수정
struct CourseModifyPath: Codable {
    let courseId: Int
}

struct CourseModifyRequest: Codable {
    let courseName: String?
    let courseDescription: String?
    let placeIds: [Int]?
    let courseImage: [String]?
    let recommendTimeStart: [String]?
    let recommendTimeEnd: [String]?

}
