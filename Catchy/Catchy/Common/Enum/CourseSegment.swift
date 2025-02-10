//
//  CourseSegment.swift
//  Catchy
//
//  Created by 정의찬 on 1/21/25.
//

import Foundation
import SwiftUI

enum CourseSegment: String, CaseIterable, SegmentProtocol {
    case diy = "코스 DIY"
    case ai = "AI 추천"
    
    var segmentTitle: String {
        self.rawValue
    }
    
    /// 세그먼트 별 텍스트 리턴
    func floatingReturnText() -> String {
        switch self {
        case .diy:
            return "코스 DIY"
        case .ai:
            return "AI 추천 코스"
        }
    }
    
    /// 세그먼트 별 이미지 리턴
    func floatingReturnIcon() -> Image {
        switch self {
        case .diy:
            return Icon.courseAI.image
        case .ai:
            return Icon.courseDIY.image
        }
    }
    
    /// 세그먼트 -> 코스타입
    var courseType: CourseType {
        switch self {
        case .diy:
            return CourseType.diy
        case .ai:
            return CourseType.ai
        }
    }
    
    
}
