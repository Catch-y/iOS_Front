//
//  CourseMyDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 내 코스 조회
struct CourseMyRequest: Codable {
    let type: CourseType
    let upperLocation: String
    let lowerLocation: String
    let lastId: Int
    
    init(type: CourseType, lastId: Int) {
        self.type = type
        self.lastId = lastId
        self.upperLocation = "all"
        self.lowerLocation = "all"
    }
}

struct CourseMyResponse: Codable {
    let content: [CourseMyContentResponse]
    let isLast: Bool
}


struct CourseMyContentResponse: Codable, Identifiable {
    var id: UUID = .init()
    let courseId: Int
    let courseType: CourseType
    let courseImage: String
    let courseName: String
    let courseDescription: String
    let categories: [CategoryType]
    
    enum CodingKeys: CodingKey {
        case courseId
        case courseType
        case courseImage
        case courseName
        case courseDescription
        case categories
    }
}
