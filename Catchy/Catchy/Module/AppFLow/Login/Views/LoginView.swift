//
//  LoginView.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - Property
    @EnvironmentObject var container: DIContainer
    @Environment(\.appFlow) var appFlow
    @State var viewModel: LoginViewModel
    @State var isVisible: Bool = false
    
    // MARK: - Constants
    private enum LoginConstants {
        static let topVspacing: CGFloat = 7
        static let topPadding: CGFloat = 9
        static let bottomVspacing: CGFloat = 21
        
        static let spacerLength: CGFloat = 140
        static let logoSize: CGSize = .init(width: 138, height: 50)
        
        static let lineSpacing: CGFloat = 2.5
        static let visibleValue: Double = 1
        static let logoText: String = "특별한 하루를 위해 \n취향을 catch:y"
    }
    
    // MARK: - Init
    init(container: DIContainer) {
        self.viewModel = .init(container: container)
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack(path: $container.navigationRouter.destination, root: {
            VStack(alignment: .leading, content: {
                Spacer().frame(maxHeight: LoginConstants.spacerLength)
                topContents
                Spacer()
                bottomContents
            })
            .navigationDestination(for: NavigationDestination.self, destination: { destination in
                NavigationRoutingView(destination: destination)
            })
            .safeAreaPadding(.horizontal, DefaultConstants.defaultSafeHorizon)
            .safeAreaPadding(.bottom, DefaultConstants.defaultSafeBottom)
            .opacity(isVisible ? LoginConstants.visibleValue : .zero)
            .task {
                withAnimation(.easeInOut(duration: DefaultConstants.animationTime)) {
                    isVisible = true
                }
            }
        })
    }
    
    // MARK: - Top
    /// 상단 탑 영역
    private var topContents: some View {
        VStack(alignment: .leading, spacing: LoginConstants.topVspacing, content: {
            Image(.appIcon)
            Image(.logo)
            topLogoTitle
        })
        .padding(.leading, LoginConstants.topPadding)
    }
    
    /// 로고 타이틀
    private var topLogoTitle: some View {
        Text(LoginConstants.logoText)
            .font(.subtitle3)
            .foregroundStyle(Color.g6)
            .lineSpacing(LoginConstants.lineSpacing)
            .multilineTextAlignment(.leading)
    }
    
    // MARK: - Bottom
    private var bottomContents: some View {
        VStack(alignment: .leading, spacing: LoginConstants.bottomVspacing, content: {
            loginBtn(.kakao, action: {
                // TODO: - Kakao LoginAction
            })
            
            loginBtn(.apple, action: {
              // TODO: - Apple LoginAction
            })
        })
    }
    
    /// 소셜 로그인 버튼 액션
    /// - Parameters:
    ///   - image: 소셜 로그인 이미지
    ///   - action: 소셜 로그인 액션
    /// - Returns: 로그인 버튼 뷰 반환
    private func loginBtn(_ image: ImageResource, action: @escaping () -> Void) ->  some View {
        Button(action: {
            action()
        }, label: {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        })
        .glassEffect(.regular)
    }
}

#Preview {
    LoginView(container: DIContainer())
        .environmentObject(DIContainer())
        .environment(AppFlow())
}
