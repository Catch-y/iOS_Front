//
//  HeaderSection.swift
//  Catchy
//
//  Created by Apple Coding machine on 11/30/25.
//

import SwiftUI

/// 홈 섹션 헤더 부분
struct HeaderSection: View {
    
    // MARK: - Property
    let baseTitle: String
    let rangeWord: [String]
    let highlightColor: Color
    let action: (() -> Void)?
    
    // MARK: - Init
    init(baseTitle: String, rangeWord: [String], highlightColor: Color = .main, action: (() -> Void)?) {
        self.baseTitle = baseTitle
        self.rangeWord = rangeWord
        self.highlightColor = highlightColor
        self.action = action
    }
    
    var body: some View {
        HStack {
            Text(baseTitle.highlight(rangeWord.map { ($0, highlightColor) }))
                .foregroundStyle(.g7)
                .font(.subtitle2)
            
            Spacer()
            
            if action != nil {
                label
            }
        }
        .padding(.horizontal, DefaultConstants.defaultSafeHorizon)
    }
    
    private var label: some View {
        Button(action: {
            action?()
        }, label: {
            HStack(spacing: 9, content: {
                Text("자세히 보기")
                    .font(.body3)
                    .foregroundStyle(.g4)
                Image(.rightChevron)
            })
        })
        .buttonStyle(.glass)
    }
}
