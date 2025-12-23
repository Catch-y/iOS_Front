//
//  ReviewTotalInfo.swift
//  Catchy
//
//  Created by euijjang97 on 12/21/25.
//

import Foundation

/// 코스 및 장소 토탈 정보
struct ReviewTotalInfo: Codable, Equatable {
    let totalCount: Int
    let averageRating: Double
    let ratingInfo: [PlaceAllReviewResponse.Rating]?
}
