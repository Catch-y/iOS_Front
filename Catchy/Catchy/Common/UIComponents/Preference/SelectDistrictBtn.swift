//
//  SelectDistrictBtn.swift
//  Catchy
//
//  Created by 정의찬 on 2/1/25.
//

import SwiftUI

struct SelectDistrictBtn: View {
    
    @Binding var isSelectedBtn: Bool
    let buttonText: String
    
    var body: some View {
        
        Button(action: {
            isSelectedBtn.toggle()
        }, label: {
            HStack(spacing: 10, content: {
                if isSelectedBtn {
                    Icon.allSelectCheckBtn.image
                        .fixedSize()
                } else {
                    Icon.allCheckBtn.image
                        .fixedSize()
                }
                
                Text(buttonText)
                    .font(.Subtitle3)
                    .foregroundStyle(Color.g6)
            })
        })
    }
}
