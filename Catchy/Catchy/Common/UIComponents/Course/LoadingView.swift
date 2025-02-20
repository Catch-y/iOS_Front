//
//  LoadingView.swift
//  Catchy
//
//  Created by LEE on 2/20/25.
//

import SwiftUI

struct LoadingView: View {
    
    let loadingType: LoadingType
    
    init(loadingType: LoadingType) {
        self.loadingType = loadingType
    }
    
    @State var activeIndex: Int = 0
        
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .frame(height: 218)
                
            VStack(spacing: 8) {
                    
                HStack(spacing: 11) {
                    ForEach(0..<4, id: \.self) { index in
                        Circle()
                            .frame(width: 14, height: 14)
                            .foregroundStyle(index < activeIndex ? .m5 : .g3)
                    }
                }.task {
                    animateCircles()
                }
                    
                Text("입력하신 정보를 토대로 \n\(loadingType.attributeText)이에요!")
                    .multilineTextAlignment(.center)
                    .lineSpacing(2.5)
                    .frame(height: 50)
                    .padding(.top, 17)
                    
                Text("잠시만 기다려주세요.")
                    .foregroundStyle(.g4)
                    .frame(height: 18)
                    .font(.body3)
                    
                    
            }
        }
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func animateCircles() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation {
                
                if activeIndex < 4 {
                    activeIndex += 1
                } else {
                    activeIndex = 0
                }
                
            }
            animateCircles()
        }
        
    }
}

#Preview {
    LoadingView(loadingType: .courseCreate)
}
