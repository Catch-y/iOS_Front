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
                return "PretendardVariable-ExtraBold"
            case .bold:
                return "PretendardVariable-Bold"
            case .semibold:
                return "PretendardVariable-SemiBold"
            case .medium:
                return "PretendardVariable-Medium"
            case .regular:
                return "PretendardVariable-Regular"
            case .light:
                return "PretendardVariable-Light"
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    // MARK: - Headline
    static var headline1: Font {
        return .pretend(type: .bold, size: 40)
    }
    
    static var headline2: Font {
        return .pretend(type: .bold, size: 32)
    }
    
    static var headline3: Font {
        return .pretend(type: .bold, size: 28)
    }
    
    // MARK: - Subtite
    static var subtitle1: Font {
        return .pretend(type: .semibold, size: 22)
    }
    
    static var subtitle2: Font {
        return .pretend(type: .semibold, size: 20)
    }
    
    static var subtitle3: Font {
        return .pretend(type: .medium, size: 17)
    }
    
    static var subtitle3_SM: Font {
        return .pretend(type: .semibold, size: 17)
    }
    // MARK: - Body
    static var body1: Font {
        return .pretend(type: .semibold, size: 14)
    }
    
    static var body1_2: Font {
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
    
    // MARK: - caption
    static var caption1: Font {
        .pretend(type: .regular, size: 11)
    }
    
    static var caption_SM: Font {
        .pretend(type: .semibold, size: 12)
    }
    
    static var caption2: Font {
        .pretend(type: .semibold, size: 8)
    }
    
    static var caption3: Font {
        .pretend(type: .regular, size: 7)
    }
    
    // MARK: - ETC
    static var naviFont: Font {
        return .pretend(type: .bold, size: 17)
    }
    
    static var buttonText: Font {
        return .pretend(type: .medium, size: 16)
    }
    
    static var dateBtnText: Font {
        return .pretend(type: .regular, size: 16)
    }
    
    static var companionBtn: Font {
        return .pretend(type: .medium, size: 16)
    }
    
    static var inputText: Font {
        return .pretend(type: .medium, size: 15)
    }
    
    static var categoryBtn: Font {
        return .pretend(type: .medium, size: 14)
    }
    
    static var tabText: Font {
        return .pretend(type: .medium, size: 12)
    }
    
    static var courseTag: Font {
        return .pretend(type: .medium, size: 9)
    }
    
    static var categoryTag: Font{
        return .pretend(type: .extraBold, size: 9)
    }
    
}
