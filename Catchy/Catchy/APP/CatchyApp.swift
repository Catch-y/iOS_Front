//
//  CatchyApp.swift
//  Catchy
//
//  Created by 정의찬 on 1/8/25.
//

import SwiftUI
import KakaoSDKCommon

@main
struct CatchyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var appFlowViewModel: AppFlowViewModel = .init()
    @StateObject var container: DIContainer = .init()
    
    init() {
        KakaoSDK.initSDK(appKey: Config.kakaoKey)
    }
    
    var body: some Scene {
        WindowGroup {
            DIYCourseCreateView(container: container)
//            switch appFlowViewModel.appState {
//            case .onBoarding:
//                OnboardingView(viewModel: appFlowViewModel)
//            case .login:
//                LoginView(container: container, appFlowViewModel: appFlowViewModel)
//                    .environmentObject(container)
//                    .environmentObject(appFlowViewModel)
//            case .preferrenceSurvey:
//                PreferencePageView(container: container)
//                    .environmentObject(appFlowViewModel)
//            case .tabView:
//                CatchyTabView()
//                    .environmentObject(container)
//                    .environmentObject(appFlowViewModel)
//            }
        }
    }
}
