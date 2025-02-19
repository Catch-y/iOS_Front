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
    
    //MARK: - Init
    
    init(isSelected: Binding<Bool>, categoryType: CategoryType) {
        self._isSelected = isSelected
        self.categoryType = categoryType
    }
    
    //MARK: - Property
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
        }, label: {
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 29)
                    .fill(isSelected ? Color.m1 : Color.white)
                    .stroke(isSelected ? Color.m6 : Color.clear, lineWidth: 1)
                    .frame(maxWidth: .infinity, minHeight: 52, alignment: .leading)
                    .s1w()
                
                HStack(spacing: 25, content: {
                    categoryType.reeturnIcon()
                        .fixedSize()
                    
                    Text(categoryType.rawValue)
                        .font(.body1)
                        .foregroundStyle(isSelected ? Color.m6 : Color.g7)
                })
                .offset(x: 28)
            }
        })
    }
}

struct MainCategoryBtn_Preview: PreviewProvider {
    static var previews: some View {
        MainCategoryBtn(isSelected: .constant(true), categoryType: .CULTURELIFE)
    }
}
