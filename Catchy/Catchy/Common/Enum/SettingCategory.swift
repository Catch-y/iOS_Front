//
//  SettingCategory.swift
//  Catchy
//
//  Created by 권용빈 on 2/4/25.
//

import SwiftUI

/// 환경설정의 각 카테고리 관리하는 enum
enum SettingCategory: CaseIterable {
    case profileSettings
    case termsAndPrivacy
    case customerSupport
    
    var title: String {
        switch self {
        case .profileSettings: 
            return "프로필 설정"
        
        case .termsAndPrivacy:
            return "약관 및 개인정보 처리 동의"
        
        case .customerSupport:
            return "고객 지원"
        }
    }
    
    func items(viewModel: SettingViewModel) -> [SettingItem] {
        switch self {
        case .profileSettings:
            return [
                SettingItem(title: "로그아웃", action: { viewModel.logout() } ),
                SettingItem(title: "회원탈퇴", action: { viewModel.deleteUser() })
            ]
        case .termsAndPrivacy:
            return [
                SettingItem(title: "이용자 약관", action: { print("이용자 약관 클릭") }),
                SettingItem(title: "개인정보 처리방침", action: { print("개인정보 처리방침 클릭") }),
                SettingItem(title: "개인정보 방침 동의 및 철회", action: { print("개인정보 방침 동의 및 철회 클릭") })
            ]
        case .customerSupport:
            return [
                SettingItem(title: "자주 묻는 질문", action: { print("자주 묻는 질문 클릭") }),
                SettingItem(title: "제안/의견 보내기", action: { print("제안/의견 보내기 클릭") }),
                SettingItem(title: "버전 정보", action: { print("버전 정보 클릭") })
            ]
        }
    }
}

struct SettingItem: Identifiable {
    let id = UUID()
    let title: String
    let action: () -> Void
}
