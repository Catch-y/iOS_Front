//
//  CourseRequest.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation

/// 내 코스 조회 API
struct CourseRequest: Codable {
    
    /// 코스의 타입
    /// DIY or AI
    let type: CourseType
    
    /// 코스 조회시 왼쪽 드랍 다운 메뉴를 통해 조회
    /// default는 모두 조회
    /// ex) 서울시
    let upperLocation: String
    
    /// 코스 조회시 오른쪽 드랍 다운 메뉴를 통해 조회
    /// default는 모두 조회
    /// ex) 동작구
    let lowerLocation: String
    
    
    let lastId: Int
}
