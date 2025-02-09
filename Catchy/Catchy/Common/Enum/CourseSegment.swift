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
    
    /// 담아둔 장소 뷰에서
    /// 코스 생성 방식(AI or DIY)에 따른 네비게이션 바 타이틀 텍스트
    var bucketViewNavigationTitle: String {
        switch self {
            
        case .ai:
            return "담아둔 장소"
            
        // TODO: - 피그마 나오면 수정
        case .diy:
            return "추천된 장소"
        }
    }
    
    /// 담아둔 장소 뷰에서
    /// 코스 생성 방식(AI or DIY)에 따른 메인 버튼의 텍스트
    var bucketViewMainBtnTitle: String {
    
        switch self {
        case .ai:
            return "코스 저장하기"
            
        case .diy:
            return "코스 생성하기"
        }
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
    
    var courseType: CourseType {
        switch self {
        case .diy:
            return CourseType.diy
        case .ai:
            return CourseType.ai
        }
    }
    
    
}
