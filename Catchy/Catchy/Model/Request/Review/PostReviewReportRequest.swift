//
//  PatchReviewReportRequest.swift
//  Catchy
//
//  Created by 권용빈 on 1/27/25.
//

import Foundation

struct PostReviewReportRequest: Codable {
    let reviewId: Int
    let reviewType: ReviewType
    let reason: ReviewReportReason
}
