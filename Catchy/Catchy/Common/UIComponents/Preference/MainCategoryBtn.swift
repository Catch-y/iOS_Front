//
//  MainCategoryBtn.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import SwiftUI

struct MainCategoryBtn: View {
    
    let categoryType: CategoryType
    let onCategorySelected: (String) -> Void
    
    @State private var isSelected: Bool = false
    
    init(categoryType: CategoryType, onCategorySelected: @escaping (String) -> Void) {
        self.categoryType = categoryType
        self.onCategorySelected = onCategorySelected
    }
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
            onCategorySelected(categoryType.rawValue)
        }, label: {
                HStack(spacing: 35, content: {
                    categoryType.reeturnIcon()
                        .fixedSize()
                    
                    Text(categoryType.rawValue)
                        .font(.categoryBtn)
                        .foregroundStyle(isSelected ? Color.m6 : Color.g7)
                })
                .frame(width: 114, alignment: .leading)
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

#Preview {
    MainCategoryBtn(categoryType: .CULTURELIFE) { catgory in
        print(catgory)
    }
}
