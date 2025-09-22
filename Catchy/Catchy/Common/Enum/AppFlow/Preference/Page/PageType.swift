//
//  PageType.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import Foundation
import SwiftUI

enum PageType {
    case one(nickname: String)
    case two
    case three
    case four
    
    var titleAttributed: AttributedString {
        switch self {
        case .one(let nickname):
            let base = AttributedString("반가워요 ")
            
            var name = AttributedString("\(nickname)")
            name.foregroundColor = .main
            
            let suffix = AttributedString("님!\n관심 있는 카테고리를 선택해주세요.")
            
            return base + name + suffix
        case .two:
            return AttributedString("")
        case .three:
            return AttributedString("거의 다 끝났어요! \n활동을 선택해주세요")
        case .four:
            return AttributedString("마지막으로 관심 지역을 \n선택해주세요")
        }
    }
    
    var fontColor: Color {
        return Color.g7
    }
}
