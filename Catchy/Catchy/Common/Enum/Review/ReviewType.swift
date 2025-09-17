//
//  ReviewType.swift
//  Catchy
//
//  Created by 권용빈 on 1/27/25.
//

import Foundation

/// 리뷰 유형 분리
enum ReviewType: String, Codable {
    case place = "PLACE"   // 장소 리뷰
    case course = "COURSE" // 코스 리뷰
}
