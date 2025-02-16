//
//  TabView.swift
//  Catchy
//
//  Created by 정의찬 on 2/10/25.
//

import SwiftUI

struct CatchyTabView: View {
    
    @State private var selectedTab: TabCase = .home
    @State private var opacity = 0.0
    
    /// 플로팅 버튼이 눌린 상태
    @State private var isFloating: Bool = false
    
    /// AI 코스 생성 로딩화면 나온 상태
    @State private var isAILoadingPresented: Bool = false
    
    /// DIY 코스 생성화면 나온 상태
    @State private var isDIYPresented: Bool = false
    
    
    @EnvironmentObject var container: DIContainer
    @EnvironmentObject var appFlowViewModel: AppFlowViewModel
    
    
    //MARK: - Property
    
    var body: some View {
        NavigationStack(path: $container.navigationRouter.destination) {
            Group {
                ZStack(alignment: .bottom, content: {
                    switch selectedTab {
                    case .home:
                        HomeView(container: container)
                    case .course:
                        CourseView(container: container, isAILoadingPresented: $isAILoadingPresented, isDIYPresented: $isDIYPresented)
                        AddFloatingButton(isOpen: $isFloating, onSubButtonTap: {
                            segment in
                            switch segment {
                            case .ai:
                                isAILoadingPresented.toggle()
                                isFloating.toggle()
                            case .diy:
                                isDIYPresented.toggle()
                                isFloating.toggle()
                            }
                        })
                            .zIndex(3)
                    case .group:
                        Text("11")
                    case .mypage:
                        Text("11")
                    }
                    
                    CustomTab(selectedTab: $selectedTab)
                    
                    if isFloating {
                        Color.black.opacity(0.8)
                            .ignoresSafeArea(.all)
                    }

                    
                    
                })
                .navigationDestination(for: NavigationDestination.self) { destination in
                    NavigationRoutingView(destination: destination)
                        .environmentObject(container)
                        .environmentObject(appFlowViewModel)
                }
                .ignoresSafeArea(.all)
            }
            .environmentObject(container)
            .environmentObject(appFlowViewModel)
        }
    }
}

struct CatchyTabView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro", "iPhone 11", "iPhone 12 mini"], id: \.self) { deviceName in
            CatchyTabView()
                .environmentObject(DIContainer())
                .environmentObject(AppFlowViewModel())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
