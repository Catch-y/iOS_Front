//
//  CatchyTab.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/14/25.
//

import SwiftUI

struct CatchyTab: View {
    @State var tabcase: TabCase = .home
    @State var isShowSearch: Bool = false
    // TODO: - AlertModel
    @EnvironmentObject var container: DIContainer
    @Environment(\.appFlow) var appFlow
    
    // MARK: - Constants
    fileprivate enum CatchyTabConstants {
        static let labelVspacing: CGFloat = 8
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack(path: $container.navigationRouter.destination, root: {
            TabView(selection: $tabcase, content: {
                ForEach(TabCase.allCases, id: \.rawValue) { tab in
                    Tab(value: tab, role: tab.tabrole, content: {
                        tabView(tab)
                    }, label: {
                        tabLabel(tab)
                    })
                }
            })
            .tint(.main)
            .tabBarMinimizeBehavior(.onScrollDown)
            .navigationDestination(for: NavigationDestination.self, destination: { destination in
                NavigationRoutingView(destination: destination)
            })
        })
    }
    
    /// 탭 내부 라벨 지정
    /// - Parameter tab: 선택된 탭
    /// - Returns: 탭 내부 라벨 반환
    private func tabLabel(_ tab: TabCase) -> some View {
        VStack(alignment: .center, spacing: CatchyTabConstants.labelVspacing, content: {
            tab.icon
                .renderingMode(.template)
            
            Text(tab.koreanText)
                .font(.caption2)
        })
    }
    
    /// 탭이 지정하는 뷰 반환
    /// - Parameter tab: 선택된 탭
    /// - Returns: 탭 지정 뷰 반환
    @ViewBuilder
    private func tabView(_ tab: TabCase) -> some View {
        switch tabcase {
        case .home:
            HomeView()
        case .course:
            Text("course")
        case .group:
            Text("group")
        case .mypage:
            Text("mypage")
        case .search:
            SearchView()
        }
    }
}

#Preview {
    CatchyTab()
        .environment(AppFlow())
        .environmentObject(DIContainer())
}
