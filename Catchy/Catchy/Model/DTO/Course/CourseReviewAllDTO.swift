//
//  CourseReviewAllDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 코스 리뷰 전체 보기
struct CourseReviewAllRequest: Codable {
    let pageSize: Int
    let lastReviewId: Int
}

struct CourseReviewAllResponse: Codable {
    let courseRating: Int
    let totalCount: Int
    let content: [CourseReviewContent]
    let last: Bool
}

struct CourseReviewContent: Codable {
    let reviewId: Int
    let comment: String
    let reviewImages: [CourseReviewImage]
    let createdAt: String
    let creatorNickname: String
}

struct CourseReviewImage: Codable {
    let reviewImageId: Int
    let imageUrl: String
}
