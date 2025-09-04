//
//  CourseReviewWriteDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 코스 리뷰 작성
struct CourseReviewWriteRequest: Codable {
    let comment: String
    let images: [Data]
}

struct CourseReviewWriteResponse: Codable {
    let reviewId: Int
    let comment: String
    let reviewImages: [ReviewImage]
    let createdAt: String
    let creatorNickname: String
}
