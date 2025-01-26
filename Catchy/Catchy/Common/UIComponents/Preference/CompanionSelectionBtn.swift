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
    
    init(companionType: CompanionType, onClickedCompanionType: @escaping (CompanionType) -> Void) {
        self.companionType = companionType
        self.onClickedCompanionType = onClickedCompanionType
    }
    
    var body: some View {
        Button(action: {
            withAnimation {
                onClickedCompanionType(companionType)
            }
        }, label: {
            VStack(spacing: 10, content: {
                companionType.returnImage()
                    .fixedSize()
                
                Text(companionType.toKorean())
                    .font(.body2)
                    .foregroundStyle(Color.g6)
            })
            .frame(width: 60, height: 60)
            .padding(.vertical, 15)
            .padding(.horizontal, 59)
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
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
