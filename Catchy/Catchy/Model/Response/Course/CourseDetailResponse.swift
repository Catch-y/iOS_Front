//
//  CourseDetailResponse.swift
//  Catchy
//
//  Created by LEE on 2/1/25.
//

import Foundation

/// 코스 상세정보 조회 API
struct CourseDetailResponse: Codable {
    
    /// 코스 Id
    let courseId: Int
    
    /// 코스 이미지
    let courseImage: String
    
    /// 코스 이름
    let courseName: String
    
    /// 코스 상세설명
    let courseDescription: String
    
    /// 코스 타입
    let courseType: CourseType
    
    /// 코스 평점
    let rating: Double
    
    /// 코스 리뷰 개수
    let reviewCount: Int
    
    /// 코스 추천 방문 시간
    let recommendTime: String
    
    /// 코스 방문자 수
    let participantCount: Int
    
    /// 장소 데이터 배열
    let placeInfo: [PlaceInfoDIYData]
}


