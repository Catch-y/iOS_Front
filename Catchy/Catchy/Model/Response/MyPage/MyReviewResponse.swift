//
//  MyReviewResponse.swift
//  Catchy
//
//  Created by 권용빈 on 2/6/25.
//

import Foundation

struct MyReviewResponse: Codable {
    
    /// 요청한 리뷰 타입 (PLACE / COURSE)
    let reviewType: ReviewType
    
    /// 작성한 리뷰 개수
    let reviewCount: Int
    
    /// 리뷰 목록
    let content: [ReviewData]
    
    /// 마지막 페이지 여부
    let last: Bool
}

/// 개별 리뷰 데이터 모델
struct ReviewData: Codable {
    
    /// 리뷰 ID
    let reviewId: Int
    
    /// 장소 또는 코스 이름
    let name: String
    
    /// 리뷰 내용 (사용자가 작성한 댓글)
    let comment: String
    
    /// 리뷰 이미지 리스트
    let reviewImages: [ReviewImage]
    
    /// 별점
    let rating: Int
    
    /// 방문 날짜
    let visitedDate: String
}

struct ReviewImage: Codable {
    let reviewImageId: Int
    let imageUrl: String
}

extension ReviewData: ReviewDataProtocol {
    var images: [any ReviewImageProtocol] {
        return reviewImages.map { $0 }
    }
    
    var userName: String? {
        return nil
    }
    
    var placeOrCourseName: String? {
        return name
    }
}

extension ReviewImage: ReviewImageProtocol { }
