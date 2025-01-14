//
//  UIFont.swift
//  Catchy
//
//  Created by LEE on 1/14/25.
//

import Foundation
import UIKit

extension UIFont {
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
    
    static func pretend(type: Pretend, size: CGFloat) -> UIFont {
        return UIFont(name: type.value, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static var ButtonText: UIFont {
        return .pretend(type: .medium, size: 16)
    }
    
    static var Headline: UIFont {
        return .pretend(type: .bold, size: 32)
    }
    
    static var Subtitle1: UIFont {
        return .pretend(type: .semibold, size: 22)
    }
    
    static var Subtitle2: UIFont {
        return .pretend(type: .semibold, size: 20)
    }
    
    static var Subtitle3: UIFont {
        return .pretend(type: .medium, size: 17)
    }
    
    static var body1: UIFont {
        return .pretend(type: .semibold, size: 14)
    }
    
    static var body2: UIFont {
        return .pretend(type: .regular, size: 12)
    }
    
    static var caption1: UIFont {
        .pretend(type: .regular, size: 13)
    }
    
    static var caption2: UIFont {
        .pretend(type: .regular, size: 11)
    }
    
    static var titleLogo: UIFont {
        return .pretend(type: .regular, size: 14)
    }
    
    static var inputText: UIFont {
        return .pretend(type: .medium, size: 15)
    }
    
    static var naviFont: UIFont {
        return .pretend(type: .bold, size: 17)
    }
}

