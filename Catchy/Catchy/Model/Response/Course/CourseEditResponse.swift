//
//  CourseEditResponse.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation

/// 코스 수정 API
struct CourseEditResponse: Codable {
    
    /// 코스 ID
    let courseId: Int
    
    /// 코스 이미지
    // TODO: - 이미지 타입 처리
    let courseImage: String
    
    /// 코스 이름
    let courseName: String
    
    /// 코스 설명
    let courseDescription: String
    
    /// 코스 타입
    let courseType: CategoryType
    
    /// 코스 평점
    let rating: Double
    
    /// 코스 리뷰 개수
    let reviewCount: Int
    
    /// 코스 추천 시간
    let recommendTime: String
    
    /// 코스 방문자 수
    let participantsNumber: Int
    
    /// 코스 장소 데이터 리스트
    let placeInfos: [PlaceInfoData]
}


struct PlaceInfoData: Codable {
    
    /// 장소 ID
    let placeId: Int
    
    /// 장소 이름
    let placeName: String
    
    /// 장소 위도
    let placeLatitude: Double
    
    /// 장소 경도
    let placeLongitude: Double
}

    
    
