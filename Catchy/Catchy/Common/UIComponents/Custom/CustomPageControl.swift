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

            HStack(spacing: 8, content: {
                ForEach(0..<totalPageCount, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 9)
                        .fill(pageCount == index ? Color.selectedPage : Color.noteSelectePage)
                        .frame(width: pageCount == index ? 23 : 9, height: 9)
                        .animation(.spring, value: pageCount)
                }
            })
            
            Text("스크롤하여 옆으로 넘겨보세요!")
                .font(.body3)
                .foregroundStyle(Color.g4)
        })
    }
}

struct CustomPageControl_Preview: PreviewProvider {
    static var previews: some View {
        CustomPageControl(pageCount: .constant(0), totalPageCount: 4)
    }
}
