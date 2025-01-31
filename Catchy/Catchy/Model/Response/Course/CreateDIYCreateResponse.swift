//
//  CreateDIYCreateResponse.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation

/// 코스 생성(DIY) API
struct CourseDIYCreateResponse: Codable {
    
    /// 코스의ID
    let courseID: Int
    
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
    
    let placeInfos: [PlaceInfoDIYData]
    
}

struct PlaceInfoDIYData: Codable {
    
    /// 장소 ID
    let placeId: Int
    
    /// 장소 이름
    let placeName: String
    
    /// 장소 위도
    let placeLatitude: Double
    
    /// 장소 경도
    let placeLongitude: Double
    
    /// 방문한 장소 인지?
    let isVisited: Bool
}
