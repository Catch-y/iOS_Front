//
//  ReviewReportResponse.swift
//  Catchy
//
//  Created by 권용빈 on 1/27/25.
//

import Foundation

struct ReviewReportResponse: Codable {
    let reportId: Int            /* 신고 ID */
    let reviewType: ReviewType     /* 리뷰 타입 선택 */
    let message: String          /* 신고 성공 메시지 */
}
