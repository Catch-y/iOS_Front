//
//  CourseListResponse.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import Foundation


struct CourseListResponse: Codable, Identifiable{
    
    // 고유 ID
    var id = UUID()
    
    // 코스 ID
    let courseId : Int
    
    // 코스 타입
    let courseType : CourseType
    
    // 코스 이미지
    let courseImage : String
    
    // 코스 이름
    let courseName : String
    
    // 코스 설명
    let courseDescription : String
    
    // 코스 카테고리 (최대 5개)
    let categorise : [CategoryType]
    
    // 코스 생성 날짜
    let createdDate : Date

    init(id: UUID = UUID(), courseId: Int, courseType: CourseType, courseImage: String, courseName: String, courseDescription: String, categorise: [CategoryType], createdDate: Date) {
        self.id = id
        self.courseId = courseId
        self.courseType = courseType
        self.courseImage = courseImage
        self.courseName = courseName
        self.courseDescription = courseDescription
        self.categorise = categorise
        self.createdDate = createdDate
    }
}
