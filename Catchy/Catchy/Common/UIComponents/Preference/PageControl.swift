//
//  PageControl.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/23/25.
//

import SwiftUI

/// 선호 조사 - 탭 페이지 컨트롤
struct PageControl: View {
    // MARK: - Property
    @Binding var pageCount: Int
    let totalPageCount: Int
    
    fileprivate enum PageControlConstants {
        static let mainVSpacing: CGFloat = 17
        static let mainHspacing: CGFloat = 8
        static let glassEffectSpacing: CGFloat = 20
        
        static let cornerRadius: CGFloat = 9
        static let pageControlSize: CGSize = .init(width: 23, height: 9)
        
        static let guideText: String = "스크롤하여 옆으로 넘겨보세요!"
    }
    
    // MARK: - Init
    init(pageCount: Binding<Int>, totalPageCount: Int) {
        self._pageCount = pageCount
        self.totalPageCount = totalPageCount
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: PageControlConstants.mainVSpacing, content: {
            pageControl
            
            Text(PageControlConstants.guideText)
                .font(.body3)
                .foregroundStyle(Color.g4)
        })
    }
    
    private var pageControl: some View {
        GlassEffectContainer(spacing: PageControlConstants.glassEffectSpacing, content: {
            HStack(alignment: .lastTextBaseline, spacing: PageControlConstants.mainHspacing, content: {
                ForEach(0..<totalPageCount, id: \.self) { index in
                    RoundedRectangle(cornerRadius: PageControlConstants.cornerRadius)
                        .fill(pageCount == index ? Color.selectedPage : Color.noteSelectePage)
                        .frame(width: pageCount == index ? PageControlConstants.pageControlSize.width : 9, height: PageControlConstants.pageControlSize.height)
                        .animation(.spring, value: pageCount)
                        .glassEffect()
                }
            })
        })
    }
}

#Preview {
    @Previewable @State var count: Int = 0
    PageControl(pageCount: $count, totalPageCount: 4)
}
