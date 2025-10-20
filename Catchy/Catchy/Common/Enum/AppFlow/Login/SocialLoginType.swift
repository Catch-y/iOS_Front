//
//  SwiftAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation
import SwiftUI

/// 소셜 로그인
enum SocialLoginType: String, Equatable, Codable {
    case kakao = "KAKAO"
    case apple = "APPLE"
    case none = "NONE"
}
