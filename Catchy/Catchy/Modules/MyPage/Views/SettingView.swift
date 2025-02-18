//
//  SettingView.swift
//  Catchy
//
//  Created by 권용빈 on 2/4/25.
//

import SwiftUI

/// 환경설정 뷰
struct SettingView: View {
    
    @StateObject var viewModel: SettingViewModel
    @EnvironmentObject var container: DIContainer
    @EnvironmentObject var appFlowViewMode: AppFlowViewModel
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 28, content: {
            CustomNavigation(action: {
                container.navigationRouter.pop()
            }, title: "환경 설정", rightNaviIcon: nil, isShadow: true)
            .padding(.bottom, 8)
            
            ForEach(SettingCategory.allCases, id: \.self) { category in
                settingSection(category: category)
                
                if category != SettingCategory.allCases.last {
                    sectionDivider()
                }
            }
            
            Spacer()
            
        })
        .ignoresSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        
    }
    
    
    /// 설정 카테고리 색션
    /// - Parameter category: enum 대 카테고리 정보
    /// - Returns: 설정 카테고리 색션
    private func settingSection(category: SettingCategory) -> some View {
        return VStack(alignment: .leading, spacing: 12, content: {
            Text(category.title)
                .font(.Subtitle3_SM)
                .foregroundStyle(Color.g7)
                .padding(.bottom, 15)
            
            ForEach(category.items(viewModel: viewModel), id: \.id) { item in
                settingItem(title: item.title, action: item.action)
                
                /// 마지막 아이템이 아닐 경우 Divider 추가
                if item.title != category.items(viewModel: viewModel).last?.title {
                    Divider()
                }
            }
        })
        .padding(.horizontal, 16)
        .background(Color.white)
    }
    
    /// 설정 항목 버튼 생성
    /// - Parameters:
    ///   - title: 버튼 제목
    ///   - action: 버튼 클릭 시 실행 액션
    /// - Returns: 설정 항목 버튼
    private func settingItem(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.Body1_2)
                    .foregroundStyle(title == "회원탈퇴" ? Color.red : Color.g7)
                Spacer()
            }
        }
        .background(Color.white)
    }

    
    /// 구분선 섹션
    /// - Returns: 구분선 역할을 하는 회색 배경
    private func sectionDivider() -> some View {
        Rectangle()
            .frame(height: 8)
            .foregroundStyle(Color.bg2)
            .frame(maxWidth: .infinity)
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

