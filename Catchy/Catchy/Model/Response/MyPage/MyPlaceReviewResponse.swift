//
//  MyPlaceReviewResponse.swift
//  Catchy
//
//  Created by 권용빈 on 2/11/25.
//

import Foundation

/// 내가 작성한 장소 리뷰 조회 response 모델
struct MyPlaceReviewResponse: Codable {
    
    /// 리뷰 타입
    let reviewType: String
    
    /// 작성한 리뷰 개수
    let reviewCount: Int
    
    /// 리뷰 목록
    let content: [PlaceReviewData]
    
    /// 마지막 페이지 여부
    let last: Bool
}

/// 개별 장소 리뷰 데이터를 담는 구조체
struct PlaceReviewData: Codable, Identifiable {
    
    var id = UUID()
    
    /// 리뷰 ID
    let reviewId: Int
    
    /// 장소 이름
    let name: String
    
    /// 카테고리 태그
    let categories: [CategoryType]
    
    /// 리뷰 내용
    let comment: String
    
    /// 리뷰 이미지 리스트
    let reviewImages: [ReviewImageData]
    
    /// 별점
    let rating: Int
    
    /// 방문 날짜
    let visitedDate: String
    
    enum CodingKeys: String, CodingKey {
        case reviewId
        case name
        case categories
        case comment
        case reviewImages
        case rating
        case visitedDate
    }
}
