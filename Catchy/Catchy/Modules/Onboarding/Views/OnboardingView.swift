//
//  OnboardingView.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        ZStack(alignment: .center, content: {
            Ellipse()
                .fill(Color(red: 1, green: 0.32, blue: 0.49).opacity(0.3))
                .frame(width: 625, height: 361).ignoresSafeArea(.all)
                .blur(radius: 125)
                .opacity(0.3)
                .offset(y: 80)
            
            VStack(spacing: 26, content: {
                
                Spacer().frame(height: 226)
                
                Icon.logo.image
                    .fixedSize()
                
                onboardingText
                
                Spacer()
            })
        })
    }
    
    private var onboardingText: some View {
        Text("특별한 하루를 위해 \n취향을 catch:y")
            .font(.Subtitle2)
            .lineSpacing(3)
            .foregroundStyle(Color.g5)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    OnboardingView()
}
