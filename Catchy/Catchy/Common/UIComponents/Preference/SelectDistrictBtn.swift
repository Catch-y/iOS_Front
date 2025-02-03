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
            withAnimation {
                isSelectedBtn.toggle()
            }
        }, label: {
            HStack(spacing: 10, content: {
                if isSelectedBtn {
                    Icon.allSelectCheckBtn.image
                        .resizable()
                        .frame(width: 24.3, height: 24.3)
                } else {
                    Icon.provinceBtn.image
                        .resizable()
                        .frame(width: 24.3, height: 24.3)
                }
                
                Text(buttonText)
                    .font(.inputText)
                    .foregroundStyle(Color.g6)
                    .multilineTextAlignment(.leading)
            })
        })
    }
}
