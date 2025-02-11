//
//  MyReviewRequest.swift
//  Catchy
//
//  Created by 권용빈 on 2/6/25.
//

import Foundation

struct MyReviewRequest: Codable {
    
    /// 리뷰 타입 (COURSE / PLACE)
    let reviewType: ReviewType
    
    /// 요청할 페이지 크기
    let pageSize: Int
    
    /// 마지막 리뷰 ID (없으면 첫 페이지)
    let lastReviewId: Int?

}
