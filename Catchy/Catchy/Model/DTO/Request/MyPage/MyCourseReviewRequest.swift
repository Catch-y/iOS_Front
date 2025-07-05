//
//  MyCourseReviewRequest.swift
//  Catchy
//
//  Created by 권용빈 on 2/11/25.
//

import Foundation

/// 내가 작성한 코스 리뷰 조회 Reqeust 모델
struct MyCourseReviewRequest: Codable {
    
    /// 한 번에 조회할 리뷰 개수
    let pageSize: Int
    
    /// 마지막으로 조회한 리뷰의 ID
    let lastReviewId: Int?
}
