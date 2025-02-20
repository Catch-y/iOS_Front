//
//  LoadingType.swift
//  Catchy
//
//  Created by LEE on 2/20/25.
//

import Foundation

/// 로딩 뷰의 타입
enum LoadingType: String {
    
    /// 리뷰 등록 로딩 메시지
    case reviewRegister = "리뷰를 등록 중"
    
    /// 코스 생성 로딩 메시지
    case courseCreate = "코스를 생성 중"
    
    /// Color.Main에 해당하는 메시지 리턴
    var attributeText: AttributedString {
        return DataFormatter.shared.makeStyledText(for: rawValue)
    }
    
}
