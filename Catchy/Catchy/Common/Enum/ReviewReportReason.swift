//
//  ReportReason.swift
//  Catchy
//
//  Created by 권용빈 on 1/27/25.
//

import Foundation

enum ReviewReportReason: String, Codable, CaseIterable {
    case notRelatedToPlace = "장소와 관련 없는 내용"
    case obsceneLanguage = "음란성, 욕설 등 부적절한 내용"
    case inappropriateAd = "부적절한 홍보 또는 광고"
    case unrelatedPhotos = "장소와 관련 없는 사진 게시"
    case personalInfoRisk = "개인정보 유출 위험"
    case offTopic = "리뷰 작성 취지에 맞지 않는 내용"
    case copyrightViolation = "저작권 도용 의심"
    case customInput = "직접 입력"
}
