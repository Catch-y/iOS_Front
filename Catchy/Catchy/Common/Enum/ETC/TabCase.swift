//
//  TabCase.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/14/25.
//

import Foundation
import SwiftUI

enum TabCase: String, CaseIterable {
    case home = "home"
    case course = "course"
    case group = "group"
    case mypage = "mypage"
    case search = "search"
    
    var koreanText: String {
        switch self {
        case .home:
            return "홈"
        case .course:
            return "코스"
        case .group:
            return "그룹"
        case .mypage:
            return "마이페이지"
        case .search:
            return "검색"
        }
    }
    
    var icon: Image {
        switch self {
        case .home:
            return .init(.home)
        case .course:
            return .init(.course)
        case .group:
            return .init(.group)
        case .mypage:
            return .init(.mypage)
        case .search:
            return .init(systemName: "magnifyingglass")
        }
    }
    
    var tabrole: TabRole? {
        switch self {
        case .search:
            return .search
        default:
            return .none
        }
    }
}
