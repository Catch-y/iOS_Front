//
//  ReviewDeleteDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 리뷰 삭제
struct ReviewDeletePath: Codable {
    let reviewId: Int
}

struct ReviewDeleteQuery: Codable {
    let reviewType: ReviewType
}

struct ReviewDeleteResponse: Codable {
    let reviewId: Int
    let reviewType: ReviewType
    let message: String
}
