//
//  CustomPageControl.swift
//  Catchy
//
//  Created by 정의찬 on 1/24/25.
//

import SwiftUI

struct CustomPageControl: View {
    
    @Binding var pageCount: Int
    let totalPageCount: Int
    
    init(pageCount: Binding<Int>, totalPageCount: Int) {
        self._pageCount = pageCount
        self.totalPageCount = totalPageCount
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 17, content: {
            ForEach(0..<totalPageCount, id: \.self) { index in
                HStack(spacing: 8, content: {
                    RoundedRectangle(cornerRadius: 9)
                        .fill(pageCount == index ? Color.pageControl : Color)
                })
            }
            
            Text("스크롤하여 옆으로 넘겨보세요!")
                .font(.body3)
                .foregroundStyle(Color.g4)
        })
    }
}
