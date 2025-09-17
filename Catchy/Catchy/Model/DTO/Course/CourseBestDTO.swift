//
//  CourseBestDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 인기 코스 조회
struct CourseBestResponse: Codable, Identifiable {
    var id: UUID = .init()
    let courseId: Int
    let courseImage: String
    let courseName: String
    
    enum CodingKeys: CodingKey {
        case courseId
        case courseImage
        case courseName
    }
}
