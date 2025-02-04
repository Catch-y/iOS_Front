//
//  PlaceDetailResponse.swift
//  Catchy
//
//  Created by LEE on 1/28/25.
//

import Foundation

/// 장소 상세 화면 API
struct PlaceDetailResponse: Codable, Hashable {
    
    /// 장소 ID
    let placeId: Int
    
    /// 장소 이미지 URL
    let imageUrl: String
    
    /// 장소 이름
    let placeName: String
    
    /// 장소 상세 설명
    let placeDescription: String
    
    /// 장소의 카테고리
    let categoryName: CategoryType
    
    /// 장소 주소
    let roadAddress: String
    
    /// 장소 영업시간
    let activeTime: String
    
    /// 장소 평점
    let rating: Double
    
    /// 누군가 방문한 장소인지?
    let isVisited: Bool
    
    /// 장소 리뷰 개수
    let reviewCount: Int
    
    /// 장소의 도메인 주소
    let placeSite: String
    
}
