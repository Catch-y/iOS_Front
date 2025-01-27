//
//  MainCategoryBtn.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import SwiftUI

struct MainCategoryBtn: View {
    
    @Binding var isSelected: Bool
    
    let categoryType: CategoryType
    
    
    init(isSelected: Binding<Bool>, categoryType: CategoryType) {
        self._isSelected = isSelected
        self.categoryType = categoryType
    }
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
        }, label: {
                HStack(spacing: 35, content: {
                    categoryType.reeturnIcon()
                        .fixedSize()
                    
                    Text(categoryType.rawValue)
                        .font(.categoryBtn)
                        .foregroundStyle(isSelected ? Color.m6 : Color.g7)
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 11)
                .padding(.horizontal, 28)
                .background(
                    RoundedRectangle(cornerRadius: 29)
                        .fill(isSelected ? Color.m1 : Color.white)
                        .stroke(isSelected ? Color.m6 : Color.clear, lineWidth: 1)
                        .s1w()
                )
        })
    }
}
