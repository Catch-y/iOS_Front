//
//  SettingView.swift
//  Catchy
//
//  Created by 권용빈 on 2/4/25.
//

import SwiftUI

struct SettingView: View {
    
    @StateObject var viewModel: SettingViewModel
    
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 28, content: {
            CustomNavigation(action: {
                print("hello")
            }, title: "환경 설정", rightNaviIcon: nil, isShadow: true)
            .padding(.bottom, 8)
            
            settingSection(
                title: "프로필 설정",
                items: [
                    ("로그아웃", { print("로그아웃 클릭") }),
                    ("회원 탈퇴", { print("회원 탈퇴 클릭") })
                ]
            )
            
            Rectangle()
                .frame(width: .infinity, height: 8)
                .foregroundStyle(Color.bg2)
            
            settingSection(
                title: "약관 및 개인정보 처리 동의",
                items: [
                    ("이용자 약관", { print("이용자 약관 클릭") }),
                    ("개인정보 처리방침", { print("개인정보 처리방침 클릭") }),
                    ("개인정보 방침 동의 및 철회", { print("개인정보 방침 동의 및 철회 클릭") })
                ]
            )
            
            Rectangle()
                .frame(width: .infinity, height: 8)
                .foregroundStyle(Color.bg2)
            
            settingSection(
                title: "고객 지원",
                items: [
                    ("자주 묻는 질문", { print("자주 묻는 질문 클릭") }),
                    ("제안/의견 보내기", { print("제안/의견 보내기 클릭") }),
                    ("버전 정보", { print("버전 정보 클릭") })
                ]
            )
            
            Spacer()
            
        })
        .ignoresSafeArea(.all)
        
    }
    
    private func settingItem(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.Body1_2)
                    .foregroundStyle(Color.g7)
                Spacer()
            }
        }
        .background(Color.white)
    }
    
    private func settingSection(title: String, items: [(String, () -> Void)]) -> some View {
        return VStack(alignment: .leading, spacing: 12, content: {
            Text(title)
                .font(.Subtitle3_SM)
                .foregroundStyle(Color.g7)
                .padding(.bottom, 15)
            
            
            ForEach(items.indices, id: \.self) { index in
                settingItem(title: items[index].0, action: items[index].1)
                
                if index != items.indices.last {
                    Divider()
                }
            }
        })
        .padding(.horizontal, 16)
        .background(Color.white)
        
    }
}

struct SettingView_Preview: PreviewProvider {
    
    static var devices = ["iPhone 11", "iPhone 16 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            SettingView(container: DIContainer())
                .environmentObject(DIContainer())
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}

