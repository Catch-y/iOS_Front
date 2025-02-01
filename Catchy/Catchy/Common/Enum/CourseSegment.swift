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
    
    func floatingReturnText() -> String {
        switch self {
        case .diy:
            return "코스 DIY"
        case .ai:
            return "AI 추천 코스"
        }
    }
    
    func floatingReturnIcon() -> Image {
        switch self {
        case .diy:
            return Icon.courseAI.image
        case .ai:
            return Icon.courseDIY.image
        }
    }
    
    
}
