//
//  DateSelectButton.swift
//  Catchy
//
//  Created by 정의찬 on 1/26/25.
//

import SwiftUI

struct DateSelectButton: View {
    
    @Binding var isSelected: Bool
    let activeDate: ActiveDate
    
    var body: some View {
        Button(action: {
            withAnimation {
                isSelected.toggle()
            }
        }, label: {
            Text(activeDate.toKorean())
                .font(.dateBtnText)
                .foregroundStyle(isSelected ? Color.white : Color.g6)
                .frame(maxWidth: 14, minHeight: 19)
                .padding(.vertical, 17)
                .padding(.horizontal, 14)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isSelected ? Color.m6 : Color.g1)
                }
        })
    }
}
