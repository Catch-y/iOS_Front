//
//  MemberMyBookMarkDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 북마크된 코스 무한 스크롤
struct MemberMyBookMarkRequest: Codable {
    let pageSize: Int
    let lastCourseId: Int?
}

struct BookMarkCourseDTO: Codable, Identifiable {
    var id: UUID = .init()
    let courseId: Int
    let courseType: String
    let courseImage: String
    let courseName: String
    let courseDescription: String
    let categories: [String]
    
    enum CodingKeys: CodingKey {
        case courseId
        case courseType
        case courseImage
        case courseName
        case courseDescription
        case categories
    }
}

struct MemberMyBookMarkResponse: Codable {
    let content: [BookMarkCourseDTO]
    let isLast: Bool
}
