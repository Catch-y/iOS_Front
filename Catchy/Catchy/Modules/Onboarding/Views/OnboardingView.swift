//
//  OnboardingView.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import SwiftUI

struct OnboardingView: View {
    
    @ObservedObject var viewModel: AppFlowViewModel
    
    var body: some View {
        ZStack(alignment: .center, content: {
            Ellipse()
                .fill(Color(red: 1, green: 0.32, blue: 0.49).opacity(0.3))
                .frame(width: 625, height: 361).ignoresSafeArea(.all)
                .blur(radius: 125)
                .opacity(0.3)
                .offset(y: 80)
            
            onboardingLogo
        })
        .task {
            viewModel.stateAppFlow { result, error in
                if let error = error {
                    print("최초 사용자 혹은 등록된 유저 아님: \(error)")
                }
            }
        }
    }
    
    private var onboardingLogo: some View {
        VStack(spacing: 7, content: {
            Icon.appIcon.image
                .fixedSize()
            
            Icon.logo.image
                .fixedSize()
        })
    }
}

#Preview {
    OnboardingView(viewModel: AppFlowViewModel())
}
