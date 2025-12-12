//
//  SingleAlertType.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/18/25.
//

import Foundation
import SwiftUI

/// 버튼 하나 Alert Type 분리
enum SingleAlertType {
    case joinPoll
    case changeNickname
    
    var titleFont: Font {
        switch self {
        case .joinPoll:
            return .subtitle3
        case .changeNickname:
            return .body2
        }
    }
    
    var titleColor: Color {
        return .black
    }
}
