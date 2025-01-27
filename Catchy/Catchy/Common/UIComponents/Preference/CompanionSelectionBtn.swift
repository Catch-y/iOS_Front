//
//  CompanionSelectionBtn.swift
//  Catchy
//
//  Created by 정의찬 on 1/26/25.
//

import SwiftUI

struct CompanionSelectionBtn: View {
    
    let companionType: CompanionType
    let onClickedCompanionType: (CompanionType) -> Void
    
    @State private var selectedBtn: Bool = false
    
    init(companionType: CompanionType, onClickedCompanionType: @escaping (CompanionType) -> Void) {
        self.companionType = companionType
        self.onClickedCompanionType = onClickedCompanionType
    }
    
    var body: some View {
        Button(action: {
            withAnimation {
                onClickedCompanionType(companionType)
                selectedBtn.toggle()
            }
        }, label: {
            VStack(spacing: 10, content: {
                companionType.returnImage()
                    .fixedSize()
                
                Text(companionType.toKorean())
                    .font(.body2)
                    .foregroundStyle(selectedBtn ? Color.m6 : Color.g6)
                    .frame(minWidth: 60)
                    .lineLimit(1)
            })
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .padding(.horizontal, 59)
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(selectedBtn ? Color.m1 : Color.white)
                    .stroke(selectedBtn ? Color.m6 : Color.clear, style: .init(lineWidth: 1))
                    .s1w()
            }
        })
    }
}

#Preview {
    CompanionSelectionBtn(companionType: .couple, onClickedCompanionType: { type in
        print(type)
    })
}
