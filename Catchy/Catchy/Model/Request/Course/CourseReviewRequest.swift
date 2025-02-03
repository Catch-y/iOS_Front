//
//  CourseReviewRequest.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation

/// 코스 리뷰 작성 API
struct CourseReviewRequest: Codable {
    
    /// 코스 ID
    let courseId: Int
    
    /// 이미지 파일
    // TODO: - 이미지 파일 타입 처리.
    let images: [String]
}
