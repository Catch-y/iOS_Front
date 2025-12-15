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
    // !!!: - FCM 토큰 연결 작업 오류 문제
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var container: DIContainer = .init()
    @State var appFlow: AppFlow = .init()
    
    init() {
        KakaoSDK.initSDK(appKey: Config.kakaoKey)
    }
    
    var body: some Scene {
        WindowGroup {
            CatchyTab()
                .environment(AppFlow())
                .environmentObject(DIContainer())
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
