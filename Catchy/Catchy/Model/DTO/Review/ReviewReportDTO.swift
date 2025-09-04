//
//  ReviewReportDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 리뷰 신고
struct ReviewReportRequest: Codable {
    let reviewType: ReviewType
    let reason: String
}

struct ReviewReportResponse: Codable {
    let reportId: Int
    let reviewType: ReviewType
    let message: String
}
