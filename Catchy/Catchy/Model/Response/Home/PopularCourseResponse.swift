//
//  PopularCourse.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import Foundation

struct PopularCourseResponse: Codable, Identifiable {
    var id = UUID()
    let courseId: Int
    let courseImage: String
    let courseName: String
    
    enum CodingKeys: CodingKey {
        case courseId
        case courseImage
        case courseName
    }
}

extension [PopularCourseResponse] {
    func zIndex(_ item: PopularCourseResponse) -> CGFloat {
        if let index = firstIndex(where: { $0.id == item.id }) {
            return CGFloat(count) - CGFloat(index)
        }
        
        return .zero
    }
}
