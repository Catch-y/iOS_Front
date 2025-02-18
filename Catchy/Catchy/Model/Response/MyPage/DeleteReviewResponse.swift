//
//  DeleteReviewResponse.swift
//  Catchy
//
//  Created by 권용빈 on 2/18/25.
//

import Foundation

struct DeleteReviewResponse: Codable {
    let reviewId: Int
    let reviewType: ReviewType
    let message: String
}
