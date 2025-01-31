//
//  CourseEditRequest.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation

/// 코스 수정 API
struct CourseEditRequest: Codable {
    
    /// 코스 ID
    let courseId: Int
    
    /// 코스 설명
    let courseDesription: String
    
    /// 장소 ID 배열
    let placeIds: [Int]
    
    /// 코스 이미지
    // TODO: - 이미지 타입 처리
    let courseImage: String
    
    /// 코스 방문 추천 시작 시간
    /// HH:mm 형식
    let recommendTimeStart: String
    
    /// 코스 방문 추천 종료 시간
    /// HH:mm 형식
    let recommendTimeEnd: String
    
}
