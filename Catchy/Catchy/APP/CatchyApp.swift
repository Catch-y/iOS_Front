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
            testView()
//            CatchyTab()
//                .environment(AppFlow())
//                .environmentObject(DIContainer())
        }
    }
}

struct testView: View {
    @State var sheet: Bool = false
    var body: some View {
        VStack {
            Button(action: {
                sheet.toggle()
            }, label: {
                Text("1")
            })
            .sheet(isPresented: $sheet, content: {
                CourseSheetView(viewModel: .init(places: [
                    .init(placeId: 0, placeName: "1", category: .BAR, placeLatitude: 1.0, placeLongitude: 1.0, isVisited: true)
                ], container: DIContainer()))
            })
        }
    }
}
