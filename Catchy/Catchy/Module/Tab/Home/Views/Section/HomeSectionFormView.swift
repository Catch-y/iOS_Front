//
//  HomeSectionFormVieww.swift
//  Catchy
//
//  Created by euijjang97 on 12/2/25.
//

import SwiftUI

/// 홈 섹션 폼 폼 뷰
struct HomeSectionFormView<Content: View>: View {
    
    let baseTitle: String
    let rangeWord: [String]
    let action: (() -> Void)?
    let content: Content
    
    init(
        baseTitle: String,
        rangeWord: [String],
        action: (() -> Void)?,
        @ViewBuilder content: () -> Content
    ) {
        self.baseTitle = baseTitle
        self.rangeWord = rangeWord
        self.action = action
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero, content: {
            Section(content: {
                content
            }, header: {
                HeaderSection(baseTitle: baseTitle, rangeWord: rangeWord, action: action)
            })
        })
    }
}
