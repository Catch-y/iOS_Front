//
//  CourseResponse.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import Foundation

/// 내 코스 조회 API
struct CourseResponse: Codable {
    
    /// 데이터를 담고 있는 배열
    let content: [CourseResponseData]
    
    /// 마지막 데이터를 포함한 응답인지
    let isLast: Bool
    
}

struct CourseResponseData: Codable, Identifiable{
    
    /// 고유 ID
    /// 뷰를 생성할 때만 사용, API와 관련 없음.
    var id = UUID()
    
    /// 코스 ID
    let courseId : Int
    
    /// 코스 타입
    /// DIY or AI
    let courseType: CourseType
    
    /// 코스 이미지
    let courseImage: String
    
    /// 코스 이름
    let courseName: String
    
    /// 코스 설명
    let courseDescription: String
    
    /// 코스 카테고리 (최대 5개)
    let categories: [CategoryType]
    
    init(id: UUID = UUID(), courseId: Int, courseType: CourseType, courseImage: String, courseName: String, courseDescription: String, categories: [CategoryType]) {
        self.id = id
        self.courseId = courseId
        self.courseType = courseType
        self.courseImage = courseImage
        self.courseName = courseName
        self.courseDescription = courseDescription
        self.categories = categories
    }
    
    enum CodingKeys : String, CodingKey {
        case courseId
        case courseType
        case courseImage
        case courseName
        case courseDescription
        case categories
    }
    
}



