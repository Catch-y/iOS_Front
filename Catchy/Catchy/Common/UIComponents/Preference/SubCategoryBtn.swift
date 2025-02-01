//
//  SubCategoryBtn.swift
//  Catchy
//
//  Created by 정의찬 on 1/25/25.
//

import SwiftUI

struct SubCategoryBtn: View {
    
    @Binding var isSelected: Bool
    let subCategoryName: String
    
    init(isSelected: Binding<Bool>, subCategoryName: String) {
        self._isSelected = isSelected
        self.subCategoryName = subCategoryName
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.4)) {
                isSelected.toggle()
            }
        }, label: {
            
            ZStack(content: {
                RoundedRectangle(cornerRadius: 30)
                    .fill(isSelected ? Color.m2 : Color.white)
                    .stroke(isSelected ? Color.m6 : Color.clear, lineWidth: 1)
                    .frame(maxWidth: .infinity, minHeight: 48)

                Text(subCategoryName)
                    .font(.Subtitle3)
                    .foregroundStyle(isSelected ? Color.m6 : Color.g6)
                    .frame(minWidth: 60)
                    .lineLimit(1)
            })
        })
    }
}

struct SubCategoryBtn_Preview: PreviewProvider {
    static var previews: some View {
        SubCategoryBtn(isSelected: .constant(false), subCategoryName: "요리주점")
    }
}
