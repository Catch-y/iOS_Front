//
//  SubCategoryBtn.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/23/25.
//

import SwiftUI

/// 선호 조사 - 서브 카테고리 선택 버튼
struct SubCategoryBtn: View {
    // MARK: - Property
    @Binding var isSelected: Bool
    let subCategory: String
    
    // MARK: - Constants
    fileprivate enum SubCategoryConstants {
        static let btnHeight: CGFloat = 48
    }
    
    // MARK: - Init
    init(isSelected: Binding<Bool>, subCategory: String) {
        self._isSelected = isSelected
        self.subCategory = subCategory
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: DefaultConstants.animationTime)) {
                isSelected.toggle()
            }
        }, label: {
            btnText
        })
        .buttonStyle(.glassProminent)
        .tint(isSelected ? Color.m6 : Color.white)
    }
    
    private var btnText: some View {
        Text(subCategory)
            .font(.Subtitle3)
            .foregroundStyle(isSelected ? Color.m2 : Color.g6)
            .frame(maxWidth: .infinity)
            .frame(height: SubCategoryConstants.btnHeight)
    }
}

#Preview {
    SubCategoryBtn(isSelected: .constant(false), subCategory: "요리주점")
}
