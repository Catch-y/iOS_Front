//
//  PlaceSearchResponse.swift
//  Catchy
//
//  Created by LEE on 1/27/25.
//

import Foundation

/// 지역명 기반 장소 검색 및 내 위치 기반 장소 검색 APi
struct PlaceSearchResponse: Codable {
        
    /// 데이터를 담고 있는 배열
    let placeInfoPreviews: [PlaceSearchResponseData]
    
    /// 마지막 데이터를 포함한 응답인지
    let isLast: Bool
}

struct PlaceSearchResponseData: Codable, Identifiable{
    
    /// 고유 ID
    /// 뷰를 생성할 때만 사용, API와 관련 없음.
    var id = UUID()
    
    /// 장소 ID
    let placeId: Int
    
    /// 장소 이름
    let placeName: String
    
    /// 장소 이미지 URL
    let placeImage: String
    
    /// 장소의 카테고리
    let category: CategoryType
    
    /// 장소 주소
    let roadAddress: String
    
    /// 장소 영업시간
    let activeTime: String
    
    /// 장소 평점
    let rating: Float
    
    /// 장소 리뷰 개수
    let reviewCount: Int
    
    init(id: UUID = UUID(), placeId: Int, placeName: String, placeImage: String, category: CategoryType, roadAddress: String, activeTime: String, rating: Float, reviewCount: Int) {
        self.id = id
        self.placeId = placeId
        self.placeName = placeName
        self.placeImage = placeImage
        self.category = category
        self.roadAddress = roadAddress
        self.activeTime = activeTime
        self.rating = rating
        self.reviewCount = reviewCount
    }
    
    enum CodingKeys: CodingKey {
        case placeId
        case placeName
        case placeImage
        case category
        case roadAddress
        case activeTime
        case rating
        case reviewCount
    }
    
}
