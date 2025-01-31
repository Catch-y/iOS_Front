//
//  CourseAICreateResponse.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation

/// 코스 생성(AI) API
struct CourseAICreateResponse: Codable {
    
    /// 코스 이름
    let courseName: String
    
    /// 코스 설명
    let courseDescription: String
    
    /// 코스 추천 방문 시간
    let recommendTime: String
    
    /// 코스 이미지
    let courseImage: String
    
    /// 코스 평점
    let courseRating: Double
    
    /// 코스 장소 정보 리스트
    let placeInfos: [PlaceInfoAIData]
}


struct PlaceInfoAIData: Codable {
    
    /// 장소 ID
    let placeId: Int
    
    /// 장소 이름
    let name: String
    
    /// 장소 주소
    let roadAddress: String
    
    /// 장소 추천 방문 시간
    let recommendVisitTime: String
}
