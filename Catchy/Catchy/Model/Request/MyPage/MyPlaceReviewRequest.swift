//
//  MyPlaceReviewRequest.swift
//  Catchy
//
//  Created by 권용빈 on 2/11/25.
//

import Foundation

/// 내가 작성한 장소 리뷰 조회 Request 모델
struct MyPlaceReviewRequest: Codable {
    
    /// 한 번에 조회할 리뷰 개수
    let pageSize: Int
    
    /// 마지막으로 조회한 장소 리뷰의 방문일
    let lastPlaceReviewDate: String?
    
    /// 마지막으로 조회한 리뷰 ID
    let lastReviewId: Int?
}
