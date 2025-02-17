//
//  CourseReviewRequest.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation

/// 코스 리뷰 작성 API
struct CourseReviewRequest: Codable {
    
    /// 코스 리뷰 내용
    let comment: String
    
}
