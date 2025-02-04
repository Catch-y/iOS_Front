//
//  MyPlaceResponse.swift
//  Catchy
//
//  Created by LEE on 2/1/25.
//

import Foundation

/// 좋아요한 장소 무한 스크롤 API
struct MyPlaceResponse: Codable {
    
    /// 마지막 페이지인가?
    let last: Bool
    
    /// 장소 데이터 리스트
    let content: [MyPageLikePlaceData]
}

struct MyPageLikePlaceData: Codable {
    
    /// 장소 ID
    let placeId: Int
    
    /// 이미지 URL
    let imageUrl: String
    
    /// 장소 이름
    let placeName: String
    
    /// 장소 설명
    let placeDescription: String
    
    /// 장소 카테고리
    let categoryName: CategoryType
    
    /// 장소 주소
    let roadAddress: String
    
    /// 장소 운영 시간
    let activeTime: String
    
    /// 장소 평점
    let rating: Double
    
    /// 방문한 장소인가?
    let isVisited: Bool
    
    /// 장소 리뷰 개수
    let reviewCount: Int
    
    /// 장소 도메인 주소
    let placeSite: String
    
}
extension MyPageLikePlaceData: PlaceDataProtocol {
    var placeImage: String { imageUrl }  // `imageUrl`을 `placeImage`로 매핑
        var category: CategoryType { categoryName }  // `categoryName`을 `category`로 매핑
    
}
