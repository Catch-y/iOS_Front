//
//  CourseCheckDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 장소 방문체크
struct CourseCheckPath: Codable {
    let courseId: Int
    let placeId: Int
}

struct CourseCheckResponse: Codable {
    let placeVisitId: Int
    let visitedDate: String
    let isVisited: Bool
}
