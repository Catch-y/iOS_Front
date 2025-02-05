//
//  AILoadingView.swift
//  Catchy
//
//  Created by LEE on 2/5/25.
//

import SwiftUI

/// AI 생성 버튼 탭 시 나타나는 뷰
struct AILoadingView: View {
    
    
    var body: some View {
        
        VStack(spacing: 88) {
            infoText
        
            ZStack {
                Icon.loading.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            
        }
        .ignoresSafeArea(edges: .top)
    }
    
    
    private var infoText: some View {
        VStack(spacing: 14) {
            Text("\(DataFormatter.shared.makeStyledText(for: UserState.shared.getUserNickname(), with: .Subtitle1)) 님에게 \(DataFormatter.shared.makeStyledText(for: "딱 맞는 코스"))를\n생성중이에요!")
                .font(.Subtitle1)
                .foregroundStyle(.g7)
                .multilineTextAlignment(.center)
                .lineSpacing(3.3)
            Text("AI가 열심히 만들고 있어요! 조금만 기다려 주세요.")
                .font(.body2)
                .foregroundStyle(.g4)
        }
    }
    
}

struct AILoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(
            ["iPhone 16 Pro Max", "iPhone 11", "iPhone 12 mini"],
            id: \.self
        ) { deviceName in
            AILoadingView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}


