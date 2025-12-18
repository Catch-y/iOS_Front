//
//  NoPoIImage.swift
//  Catchy
//
//  Created by euijjang97 on 12/18/25.
//

import Foundation
import SwiftUI

struct NoPoIImage: View {
    let size: CGSize
    let ratio: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.m2)
                .frame(maxWidth: size.width)
                .frame(height: size.height)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            innerContent
        }
    }
    
    private var innerContent: some View {
        VStack(spacing: 10, content: {
            Image(.noPoI)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
            
            Text("등록된 사진이 없습니다.")
                .foregroundStyle(.black)
                .font(.inputText)
        })
    }
}
