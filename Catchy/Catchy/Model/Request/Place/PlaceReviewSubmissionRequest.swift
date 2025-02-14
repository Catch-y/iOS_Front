//
//  PlaceReviewSubmissionRequest.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import Foundation

/// 장소 평점/리뷰 달기 API
struct PlaceReviewSubmissionRequest: Codable {
        
    /// 장소 평점
    let rating: Int
    
    /// 리뷰 내용
    let comment: String
    
    /// 방문날짜
    let visitedDate: String
    
}
