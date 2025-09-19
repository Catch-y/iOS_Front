//
//  OnboardingView.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import SwiftUI

/// 온보딩 뷰
struct OnboardingView: View {
    // MARK: - Property
    @Environment(\.appFlow) var appFlow
    
    // MARK: - Constants
    private enum OnboardingConstants {
        static let logoVspacing: CGFloat = 7
        
        static let bgSize: CGSize = .init(width: 625, height: 361)
        
        static let bgOffsetY: CGFloat = 80
        static let bgOpacity: Double = 0.3
        static let bgBlur: CGFloat = 125
        static let timer: TimeInterval = 2
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .center, content: {
            bgGradient
            onboardingLogo
        })
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + OnboardingConstants.timer, execute: {
                appFlow.stateAppFlow { result, error in
                    if let error = error {
                        #if DEBUG
                        print("최초 사용자 혹은 등록된 유저 아님: \(error)")
                        #endif
                    }
                }
            })
        }
    }
    
    /// 배경 그라디언트
    private var bgGradient: some View {
        Ellipse()
            .fill(Color(red: 1, green: 0.32, blue: 0.49).opacity(0.3))
            .frame(width: OnboardingConstants.bgSize.width, height: OnboardingConstants.bgSize.height)
            .blur(radius: OnboardingConstants.bgBlur)
            .opacity(OnboardingConstants.bgOpacity)
            .offset(y: OnboardingConstants.bgOffsetY)
    }
    
    /// 온보딩 로고
    private var onboardingLogo: some View {
        VStack(spacing: OnboardingConstants.logoVspacing, content: {
            Image(.appIcon)
            Image(.logo)
        })
    }
}

#Preview {
    OnboardingView()
}
