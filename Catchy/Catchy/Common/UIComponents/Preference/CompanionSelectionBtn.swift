//
//  CompanionSelectionBtn.swift
//  Catchy
//
//  Created by 정의찬 on 1/26/25.
//

import SwiftUI

struct CompanionSelectionBtn: View {
    
    @Binding var isSelected: Bool
    let companionType: CompanionType
    
    init(isSelected: Binding<Bool>, companionType: CompanionType) {
        self._isSelected = isSelected
        self.companionType = companionType
    }
    
    
    var body: some View {
        Button(action: {
            withAnimation {
                isSelected.toggle()
            }
        }, label: {
            VStack(spacing: 10, content: {
                companionType.returnImage()
                    .fixedSize()
                
                Text(companionType.toKorean())
                    .font(.body2)
                    .foregroundStyle(isSelected ? Color.m6 : Color.g6)
                    .frame(minWidth: 60)
                    .lineLimit(1)
            })
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .padding(.horizontal, 59)
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(isSelected ? Color.m1 : Color.white)
                    .stroke(isSelected ? Color.m6 : Color.clear, style: .init(lineWidth: 1))
                    .s1w()
            }
        })
    }
}
