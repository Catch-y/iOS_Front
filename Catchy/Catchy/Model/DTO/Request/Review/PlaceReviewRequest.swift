//
//  ReviewRequest.swift
//  Catchy
//
//  Created by 권용빈 on 1/25/25.
//

import Foundation

/// 내 장소 리뷰 조회 요청 모델
struct PlaceReviewRequest: Codable {
    let pageSize: Int
    let lastPlaceReviewDate: String?
    let lastPlaceReviewId: Int?
}
