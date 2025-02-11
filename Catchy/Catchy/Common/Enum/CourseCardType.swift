//
//  CourseCardType.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import SwiftUI

enum CourseCardType {
    case myPage  // 마이페이지용 (북마크한 코스)
    case course  // 코스용 (기존 기본값)
    
    /// 이미지 크기 정의
    var imageSize: (width: CGFloat, height: CGFloat) {
        switch self {
        case .myPage: return (133, 100)
        case .course: return (133, 116)
        }
    }
    
    /// 제목 폰트 설정
    var titleFont: Font {
        switch self {
        case .myPage: return .body1
        case .course: return .Subtitle3_SM
        }
    }

    /// 카테고리 태그 + 설명 텍스트 추가 패딩 (Vstack(spacing: 6)을 제외한 추가 패딩)
    var categoryExtraPadding: CGFloat {
        switch self {
        case .myPage: return 8  // 최종 6 + 8 = 14
        case .course: return 15   // 최종 6 + 15 = 21
        }
    }
    /// 카드 높이 설정
    var cardHeight: CGFloat {
        switch self {
        case .myPage: return 140
        case .course: return 158
        }
    }
    
    /// LazyVGrid 열 개수
    var lazyVGridColumnCount: Int {
        switch self {
        case .myPage: return 5
        case .course: return 4
        }
    }
    
    /// 설명 텍스트 프레임 높이
    var descriptionFrameHeight: CGFloat {
        switch self {
        case .myPage: return 20
        case .course: return 36
        }
    }

    /// 설명 텍스트 최대 줄 수
    var descriptionLineLimit: Int {
        switch self {
        case .myPage: return 1
        case .course: return 2
        }
    }
}
