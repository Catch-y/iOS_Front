//
//  CourseInfoResponse.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import Foundation

/// AI 추천 5개 데이터
struct CourseInfoResponse: Codable, Identifiable {
    var id = UUID()
    var courseId: Int
    let courseName: String
    let courseDescription: String
    let courseImage: String
    let courseType: CourseType
    
    enum CodingKeys: CodingKey {
        case courseId
        case courseName
        case courseDescription
        case courseImage
        case courseType
    }
}
