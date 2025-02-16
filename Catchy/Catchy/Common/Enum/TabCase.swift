//
//  TabCase.swift
//  Catchy
//
//  Created by 정의찬 on 2/10/25.
//

import Foundation

/// 캐치 탭 정리
enum TabCase: String, CaseIterable {
    case home = "home"
    case course = "course"
    case group = "group"
    case mypage = "mypage"
    
    func toKorean() -> String {
        switch self {
        case .home:
            return "홈"
        case .course:
            return "진단"
        case .group:
            return "그룹"
        case .mypage:
            return "마이페이지"
        }
    }
}
