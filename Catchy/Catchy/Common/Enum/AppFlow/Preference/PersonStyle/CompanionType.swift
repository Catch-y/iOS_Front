//
//  CompanionType.swift
//  Catchy
//
//  Created by 정의찬 on 1/26/25.
//

import SwiftUI

/// 같이 활동하는 유형
enum CompanionType: String, CaseIterable, Codable {
    case alone = "ALONE"
    case friends = "FRIENDS"
    case couple = "COUPLE"
    case family = "FAMILY"
    
    func toKorean() -> String {
        switch self {
        case .alone:
            return "혼자 놀기"
        case .friends:
            return "친구와 함께"
        case .family:
            return "연인과 함께"
        case .couple:
            return "가족과 함께"
        }
    }
    
    func returnImage() -> ImageResource {
        switch self {
        case .alone:
            return .solo
        case .friends:
            return .friends
        case .couple:
            return .couple
        case .family:
            return .family
        }
    }
}

