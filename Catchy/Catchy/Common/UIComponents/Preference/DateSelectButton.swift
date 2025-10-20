//
//  DateSelectButton.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/24/25.
//

import SwiftUI

/// 선호 조사 - 날짜 선택 버튼
struct DateSelectButton: View {
    // MARK: - Property
    @Binding var isSelected: Bool
    let activaDate: ActiveDate
    
    // MARK: - Constants
    fileprivate enum DateSelectButtonConstant {
        static let btnHegiht: CGFloat = 54
        static let cornerRadius: CGFloat = 10
    }
    
    // MARK: - Init
    init(isSelected: Binding<Bool>, activaDate: ActiveDate) {
        self._isSelected = isSelected
        self.activaDate = activaDate
    }

    // MARK: - Body
    var body: some View {
        Button(action: {
            isSelected.toggle()
        }, label: {
            ZStack {
                btnBg
                btnText
            }
        })
    }
    
    /// 버튼 백그라운드
    private var btnBg: some View {
        RoundedRectangle(cornerRadius: DateSelectButtonConstant.cornerRadius)
            .fill(isSelected ? Color.m6 : Color.g1)
            .glassEffect(.regular, in: .rect(cornerRadius: DateSelectButtonConstant.cornerRadius))
            .frame(maxWidth: .infinity)
            .frame(height: DateSelectButtonConstant.btnHegiht)
    }
    
    /// 버튼 텍스트
    private var btnText: some View {
        Text(activaDate.text)
            .font(.dateBtnText)
            .foregroundStyle(isSelected ? Color.white : Color.g6)
    }
}

#Preview {
    DateSelectButton(isSelected: .constant(true), activaDate: .monDay)
}
