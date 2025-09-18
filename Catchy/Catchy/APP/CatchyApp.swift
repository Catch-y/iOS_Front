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
    @StateObject var container: DIContainer = .init()
    @State var appFlow: AppFlow = .init()
    
    init() {
        KakaoSDK.initSDK(appKey: Config.kakaoKey)
        LocationManager.shared.requestAuthorization()
    }
    
    var body: some Scene {
        WindowGroup {
            Text("test")
                .task {
                    appDelegate.configure(container: container)
                }
        }
    }
}
