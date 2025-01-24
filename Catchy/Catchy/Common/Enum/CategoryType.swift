//
//  CategoryType.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import Foundation
import SwiftUI

enum CategoryType: String, Codable, CaseIterable {
    case CAFE = "카페"
    case BAR = "주류"
    case RESTAURANT = "음식점"
    case EXPERIENCE = "체험"
    case CULTURELIFE = "문화생활"
    case SPORT = "스포츠"
    case REST = "휴식"
    
    func reeturnIcon() -> Image {
        switch self {
        case .CAFE:
            return Icon.cafe.image
        case .BAR:
            return Icon.tassels.image
        case .RESTAURANT:
            return Icon.restaurant.image
        case .EXPERIENCE:
            return Icon.experience.image
        case .CULTURELIFE:
            return Icon.cultureLife.image
        case .SPORT:
            return Icon.sports.image
        case .REST:
            return Icon.breaks.image
        }
    }
}
