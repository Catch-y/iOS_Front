//
//  GetCourseInfo.swift
//  Catchy
//
//  Created by LEE on 1/23/25.
//

import Foundation

struct GetCourseInfoResponse: Codable {
    
    var contents : [ContentCourse]
    
}

struct ContentCourse: Codable, Identifiable{
    
    var courseId = UUID()
    let id: Int
    let courseType: String
    let courseImage: String
    let courseName: String
    let courseDescription: String
    let categories: String
    let createdDate: String
    
    enum CodingKeys: CodingKey {
        case id
        case courseType
        case courseImage
        case courseName
        case courseDescription
        case categories
        case createdDate
    }
}
