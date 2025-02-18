//
//  PatchReviewReportRequest.swift
//  Catchy
//
//  Created by 권용빈 on 1/27/25.
//

import Foundation

struct ReviewReportRequest: Codable {
    let reviewType: ReviewType
    let reason: String
}
