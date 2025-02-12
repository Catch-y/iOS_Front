//
//  TabCase.swift
//  Catchy
//
//  Created by 정의찬 on 2/10/25.
//

import Foundation

enum TabCase: String, CaseIterable {
    case home = "home"
    case course = "course"
    case group = "group"
    case myPage = "myPage"
    
    func toKorean() -> String {
        switch self {
        case .home:
            return "홈"
        case .course:
            return "진단"
        case .group:
            return "그룹"
        case .myPage:
            return "마이페이지"
        }
    }
}
