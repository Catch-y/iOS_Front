//
//  TabView.swift
//  Catchy
//
//  Created by 정의찬 on 2/10/25.
//

import SwiftUI

struct CatchyTabView: View {
    // MARK: - State Property
    
    /* Tab Animation */
    
    @State private var scale: CGFloat = 0.95
    @State private var tabOpacity = 0.0
    
    @State private var selectedTab: TabCase = .home
    @State private var opacity = 0.0
    
    /// 플로팅 버튼이 눌린 상태
    @State private var isFloating: Bool = false
    
    /// AI 코스 생성 로딩화면 나온 상태
    @State private var isAILoadingPresented: Bool = false
    
    /// DIY 코스 생성화면 나온 상태
    @State private var isDIYPresented: Bool = false
    
    @State private var showEditingNickname: Bool = false
    
    
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
                        GroupTabView(container: container)
                            .environmentObject(container)
                    case .mypage:
                        MyPageView(container: container, isEditingNickname: $showEditingNickname)
                            .environmentObject(container)
                            .environmentObject(appFlowViewModel)
                    }
                    
                    CustomTab(selectedTab: $selectedTab)
                    
                    if isFloating || showEditingNickname {
                        Color.black.opacity(0.8)
                            .ignoresSafeArea(.all)
                    }
                    
                    if showEditingNickname {
                        NicknameEditView(isPresented: $showEditingNickname, container: DIContainer())
                            .zIndex(3)
                    }
                    
                })
                .opacity(tabOpacity)
                .scaleEffect(scale)
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        tabOpacity = 1
                        scale = 1
                    }
                }
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
        ForEach(["iPhone 16 Pro Max", "iPhone 11", "iPhone 12 mini"], id: \.self) { deviceName in
            CatchyTabView()
                .environmentObject(DIContainer())
                .environmentObject(AppFlowViewModel())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
