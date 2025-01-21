//
//  CourseSegment.swift
//  Catchy
//
//  Created by 정의찬 on 1/21/25.
//

import Foundation

enum CourseSegment: String, CaseIterable, SegmentProtocol {
    case diy = "코스 DIY"
    case ai = "AI 추천"
    
    var segmentTitle: String {
        self.rawValue
    }
}
