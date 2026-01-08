//
//  CourseReviewAllDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 코스 리뷰 전체 보기
struct CourseReviewAllPath: Codable {
    let courseId: Int
}

struct CourseReviewAllQuery: Codable {
    let pageSize: Int
    let lastReviewId: Int?
}

struct CourseReviewAllResponse: Codable {
    let courseRating: Double
    let totalCount: Int
    let content: [CourseReviewContent]
    let last: Bool
}

struct CourseReviewContent: Codable, Identifiable {
    var id: UUID = .init()
    let reviewId: Int
    let comment: String
    let reviewImages: [ReviewImage]
    let createdAt: String
    let creatorNickname: String
    
    enum CodingKeys: CodingKey {
        case reviewId
        case comment
        case reviewImages
        case createdAt
        case creatorNickname
    }
}
