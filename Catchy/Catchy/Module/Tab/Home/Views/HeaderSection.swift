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
    
    // MARK: - Init
    init(baseTitle: String, rangeWord: [String], highlightColor: Color = .main) {
        self.baseTitle = baseTitle
        self.rangeWord = rangeWord
        self.highlightColor = highlightColor
    }
    
    var body: some View {
        Text(baseTitle.highlight(rangeWord.map { ($0, highlightColor) }))
            .foregroundStyle(.g7)
            .font(.Subtitle2)
    }
}

#Preview {
    HeaderSection(baseTitle: "가장 유연한 단던", rangeWord: ["유연"])
}
