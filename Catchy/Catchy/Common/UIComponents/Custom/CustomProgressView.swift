//
//  CustomProgressView.swift
//  Catchy
//
//  Created by 정의찬 on 2/12/25.
//

import SwiftUI

/// 커스텀 프로그레스 뷰, MianColor 사용
struct CustomProgressView: View {
    
    let text: String
    let height: CGFloat
    
    init(text: String, height: CGFloat) {
        self.text = text
        self.height = height
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.clear)
                .stroke(Color.g3, style: .init(lineWidth: 1))
                .frame(maxWidth: .infinity, minHeight: height)
            
            ProgressView(label: {
                Text(text)
                    .font(.Body1_2)
                    .foregroundStyle(Color.g4)
                    .multilineTextAlignment(.center)
                    .lineSpacing(2.5)
            })
        }
    }
}
