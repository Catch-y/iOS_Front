//
//  ReviewReportResponse.swift
//  Catchy
//
//  Created by 권용빈 on 1/27/25.
//

import Foundation

struct ReviewReportResponse: Codable {
    let reviewId: Int            // 리뷰 ID
    let reviewType: ReviewType     // 리뷰 타입 선택
    let message: String          // 신고 성공 메시지
}
