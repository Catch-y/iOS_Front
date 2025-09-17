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
    
    init() {
        KakaoSDK.initSDK(appKey: Config.kakaoKey)
        BaseLocationManager.shared.requestLocationAuthorization()
    }
    
    var body: some Scene {
        WindowGroup {
            Text("test")
        }
    }
}
