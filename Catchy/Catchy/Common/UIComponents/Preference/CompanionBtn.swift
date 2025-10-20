//
//  CompanionBtn.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/24/25.
//

import SwiftUI

/// 선호 조사 - 함께할 동료 선택 버튼
struct CompanionBtn: View {
    // MARK: - Property
    @Binding var isSelected: Bool
    let companionType: CompanionType
    
    // MARK:- Property
    fileprivate enum CompanionBtnConstants {
        static let btnVspacing: CGFloat = 10
        
        static let btnHeight: CGFloat = 90
        
        static let lineLimit: Int = 1
        static let cornerRadius: CGFloat = 15
    }
    
    // MARK: - Init
    init(isSelected: Binding<Bool>, companionType: CompanionType) {
        self._isSelected = isSelected
        self.companionType = companionType
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            isSelected.toggle()
        }, label: {
            ZStack {
                rectangle
                btnText
            }
        })
    }
    
    private var rectangle: some View {
        RoundedRectangle(cornerRadius: CompanionBtnConstants.cornerRadius)
            .fill(isSelected ? Color.m1 : Color.white)
            .frame(maxWidth: .infinity)
            .frame(height: CompanionBtnConstants.btnHeight)
            .glassEffect(.regular.interactive(), in: .rect(cornerRadius: CompanionBtnConstants.cornerRadius))
    }
    
    /// 버튼 내부 텍스트
    private var btnText: some View {
        VStack(alignment: .center, spacing: CompanionBtnConstants.btnVspacing, content: {
            Image(companionType.companionImage)
            Text(companionType.btnText)
                .font(.companionBtn)
                .foregroundStyle(isSelected ? Color.m6 : Color.g6)
                .lineLimit(CompanionBtnConstants.lineLimit)
        })
    }
}

#Preview {
    CompanionBtn(isSelected: .constant(true), companionType: .alone)
}
