//
//  SwiftAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretend {
        case extraBold
        case bold
        case semibold
        case medium
        case regular
        case light
        
        var value: String {
            switch self {
            case .extraBold:
                return "Pretendard-ExtraBold"
            case .bold:
                return "Pretendard-Bold"
            case .semibold:
                return "Pretendard-SemiBold"
            case .medium:
                return "Pretendard-Medium"
            case .regular:
                return "Pretendard-Regular"
            case .light:
                return "Pretendard-Light"
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static var ButtonText: Font {
        return .pretend(type: .medium, size: 16)
    }
    
    static var Headline: Font {
        return .pretend(type: .bold, size: 32)
    }
    
    static var Subtitle1: Font {
        return .pretend(type: .semibold, size: 22)
    }
    
    static var Subtitle2: Font {
        return .pretend(type: .semibold, size: 20)
    }
    
    static var Subtitle3: Font {
        return .pretend(type: .medium, size: 17)
    }
    
    static var body1: Font {
        return .pretend(type: .semibold, size: 14)
    }
    
    static var body2: Font {
        return .pretend(type: .regular, size: 12)
    }
    
    static var caption1: Font {
        .pretend(type: .regular, size: 13)
    }
    
    static var caption2: Font {
        .pretend(type: .regular, size: 11)
    }
    
    static var titleLogo: Font {
        return .pretend(type: .regular, size: 14)
    }
    
    static var inputText: Font {
        return .pretend(type: .medium, size: 15)
    }
}
