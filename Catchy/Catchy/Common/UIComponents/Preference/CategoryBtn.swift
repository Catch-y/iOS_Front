//
//  CategoryBtn.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/22/25.
//

import SwiftUI

/// 선호 조사 - 카테고리 선택 버튼
struct CategoryBtn: View {
    
    // MARK: - Property
    @Binding var isSelected: Bool
    let category: CategoryType
    
    // MARK: - Constants
    fileprivate enum CategoryConstants {
        static let btnPadding: EdgeInsets = .init(top: 11, leading: 28, bottom: 11, trailing: 28)
        static let btnHeight: CGFloat = 35
        static let btnTextWidth: CGFloat = 114
    }
    
    // MARK: - Init
    init(isSelected: Binding<Bool>, category: CategoryType) {
        self._isSelected = isSelected
        self.category = category
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            isSelected.toggle()
        }, label: {
            btnContent
        })
        .buttonStyle(.glassProminent)
        .tint(isSelected ? Color.m1 : Color.white)
    }
    
    /// 버튼 컨텐츠
    private var btnContent: some View {
        Label(title: {
            btnText
        }, icon: {
            Image(category.categoryImage)
        })
    }
    
    /// 버튼 내부 텍스트
    private var btnText: some View {
        Text(category.rawValue)
            .frame(width: CategoryConstants.btnTextWidth, alignment: .center)
            .frame(height: CategoryConstants.btnHeight)
            .font(.body1)
            .foregroundStyle(isSelected ? Color.m6 : Color.black)
    }
}

#Preview {
    @Previewable @State var isSelected: Bool = true
    CategoryBtn(isSelected: $isSelected, category: .CULTURELIFE)
}
