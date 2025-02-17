//
//  CourseDIYCreateResponse.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation

/// 코스 생성(DIY) API
struct CourseDIYCreateResponse: Codable {
    
    /// 코스의ID
    let courseId: Int
    
    /// 코스 이미지
    let courseImage: String
    
    /// 코스 이름
    let courseName: String
    
    /// 코스 설명
    let courseDescription: String
    
    /// 코스 타입
    let courseType: CourseType
    
    /// 코스 평점
    let rating: Double
    
    /// 코스 리뷰 개수
    let reviewCount: Int
    
    /// 코스 추천 시간
    let recommendTime: String
    
    /// 방문자 수
    let participantsNumber: Int
    
    /// 장소 데이터
    let placeInfos: [PlaceInfoData]
    
}


