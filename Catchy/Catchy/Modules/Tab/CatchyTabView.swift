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
    
    @EnvironmentObject var container: DIContainer
    @EnvironmentObject var appFlowViewModel: AppFlowViewModel
    
    var body: some View {
        NavigationStack(path: $container.navigationRouter.destination) {
            Group {
                ZStack(alignment: .bottom, content: {
                    switch selectedTab {
                    case .home:
                        HomeView(container: container)
                    case .course:
                        Text("11")
                            .backgroundStyle(Color.red)
                    case .group:
                        Text("11")
                    case .myPage:
                        Text("11")
                    }
                    
                    CustomTab(selectedTab: $selectedTab)
                    
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

#Preview {
    CatchyTabView()
        .environmentObject(DIContainer())
        .environmentObject(AppFlowViewModel())
}
