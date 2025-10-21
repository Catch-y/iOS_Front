//
//  HorizonLoading.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/20/25.
//

import SwiftUI

/// 가로 로딩 애니메이션
struct HorizonLoading: View {
    // MARK: - Property
    @State var actionIndex: Int = 0
    let numberCircle: Int = 4
    let animationDuration: TimeInterval = 0.8
    let spcing: CGFloat = 11
    let circleSize: CGSize = .init(width: 14, height: 14)
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: spcing, content: {
            ForEach(0..<numberCircle, id: \.self) { index in
                Circle()
                    .fill(index < actionIndex ? .main : .g3)
                    .frame(width: circleSize.width, height: circleSize.height)
                    .animation(.easeInOut(duration: animationDuration), value: actionIndex)
            }
        })
        .task {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true, block: { _ in
            withAnimation {
                actionIndex = (actionIndex + 1) % (numberCircle + 1)
                
                if actionIndex == numberCircle {
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration, execute: {
                        actionIndex = 0
                    })
                }
            }
        })
    }
}

#Preview {
    HorizonLoading()
}
