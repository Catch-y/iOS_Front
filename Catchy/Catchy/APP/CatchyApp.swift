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
            testView()
                .task {
                    appDelegate.configure(container: container)
                }
        }
    }
}

struct testView: View {
    @State var navi: Bool = false
    var body: some View {
        NavigationStack {
            Button("cc", action: {
                navi.toggle()
            })
            .navigationDestination(isPresented: $navi, destination: {
                SignUpView(signUpData: .init(accessToken: "1", authorizationCode: "1", email: "1", loginType: .apple), container: DIContainer(), appFlow: AppFlow())
                    .environmentObject(DIContainer())
            })
        }
    }
}
