//
//  CompanionType.swift
//  Catchy
//
//  Created by 정의찬 on 1/26/25.
//

import SwiftUI

enum CompanionType: String, CaseIterable, Codable {
    case alone = "ALONE"
    case friends = "FFRIENDSR"
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
    
    func returnImage() -> Image {
        switch self {
        case .alone:
            return Icon.solo.image
        case .friends:
            return Icon.friends.image
        case .couple:
            return Icon.couple.image
        case .family:
            return Icon.family.image
        }
    }
}

