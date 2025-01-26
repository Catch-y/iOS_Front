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
    
    static var Headline1: Font {
        return .pretend(type: .bold, size: 40)
    }
    
    static var Headline2: Font {
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
    
    static var Subtitle3_SM: Font {
        return .pretend(type: .semibold, size: 17)
    }
    
    static var body1: Font {
        return .pretend(type: .semibold, size: 14)
    }
    
    static var Body1_2: Font {
        return .pretend(type: .regular, size: 14)
    }
    
    static var body2: Font {
        return .pretend(type: .regular, size: 13)
    }
    
    static var body3: Font {
        return .pretend(type: .regular, size: 12)
    }
    
    static var body3_SM: Font {
        return .pretend(type: .semibold, size: 12)
    }
    
    static var caption1: Font {
        .pretend(type: .regular, size: 11)
    }
    
    static var caption_SM: Font {
        .pretend(type: .semibold, size: 11)
    }
    
    static var caption2: Font {
        .pretend(type: .semibold, size: 8)
    }
    
    static var caption3: Font {
        .pretend(type: .regular, size: 7)
    }
    
    //MARK: - ETC
    static var naviFont: Font {
        return .pretend(type: .bold, size: 17)
    }
    
    static var buttonText: Font {
        return .pretend(type: .medium, size: 16)
    }
    
    static var dateBtnText: Font {
        return .pretend(type: .regular, size: 16)
    }
    
    static var inputText: Font {
        return .pretend(type: .medium, size: 15)
    }
    
    static var categoryBtn: Font {
        return .pretend(type: .medium, size: 14)
    }
    
    static var courseTag: Font {
        return .pretend(type: .medium, size: 9)
    }
    
    
}
