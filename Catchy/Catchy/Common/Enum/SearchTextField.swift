//
//  t.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import Foundation
import SwiftUI

enum SearchTextField {
    case homeView
    case searchView
    case mapView
    
    func placeholderText() -> String {
        switch self {
        case .homeView:
            return "원하는 장소를 검색해보세요!"
        case .searchView:
            return "원하는 장소나 카테고리를 검색해보세요!"
        case .mapView:
            return "검색어를 입력하세요"
        }
    }
    
    func placeholderFont() -> Font {
        switch self {
        case .homeView:
            return .caption2
        case .searchView, .mapView:
            return .caption1
        }
    }
    
    func placeholderWidth() -> CGFloat {
        switch self {
        case .homeView:
            return 200
        case .searchView:
            return 329
        case .mapView:
            return 327
        }
    }
    
    func placeholderHeight() -> CGFloat {
        switch self {
        case .homeView:
            return 23
        case .searchView, .mapView:
            return 26
        }
    }
    
    func textFieldBgColor() -> Color {
        switch self {
        case .homeView:
            return Color.g1
        case .searchView, .mapView:
            return Color.white
        }
    }
    
    func textFieldBorderColor() -> Color {
        switch self {
        case .homeView, .mapView:
            return Color.clear
        case .searchView:
            return Color.m5
        }
    }
    
    func textFieldWidth() -> CGFloat {
        switch self {
        case .homeView:
            return 230
        case .searchView, .mapView:
            return 370
        }
    }
    
    func textFieldHeight() -> CGFloat {
        switch self {
        case .homeView:
            return 32
        case .searchView:
            return 48
        case .mapView:
            return 56
        }
    }
    
    func textFieldFont() -> Font {
        switch self {
        case .homeView:
            return .pretend(type: .medium, size: 13)
        case .searchView, .mapView:
            return .inputText
        }
    }
}
