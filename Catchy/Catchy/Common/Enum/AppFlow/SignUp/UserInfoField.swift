//
//  InputTextType.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import Foundation
import UIKit

/// 회원가입시 이메일 닉네임 입력
enum UserInfoField {
    case email
    case nickname
    
    var title: String {
        switch self {
        case .email:
            return "이메일"
        case .nickname:
            return "닉네임"
        }
    }
    
    var placeholder: String {
        switch self {
        case .email:
            return ""
        case .nickname:
            return "닉네임 8자까지 입력해주세요"
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        case .nickname:
            return .default
        }
    }
}
