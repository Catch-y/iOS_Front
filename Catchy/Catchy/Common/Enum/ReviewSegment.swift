//
//  ReviewSegment.swift
//  Catchy
//
//  Created by 권용빈 on 2/8/25.
//

import Foundation

/// 리뷰 유형 분리
enum ReviewSegment: String, CaseIterable {
    case course = "코스 리뷰"
    case place  = "장소 리뷰"
    
    /// 텍스트 표시용
    var segmentTitle: String { self.rawValue }

}
