//
//  MainButton.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import SwiftUI

struct MainButton: View {
    
    // MARK: - Property
    let btnType: MainBtnType
    let height: CGFloat
    let action: () -> Void
    
    // MARK: - Constants
    private enum MainButtonConstant {
        static let cornerRadius: CGFloat = 30
        static let lineWidth: CGFloat = 1
    }
    
    // MARK: - Init
    init(btnType: MainBtnType, height: CGFloat = 60, action: @escaping () -> Void) {
        self.btnType = btnType
        self.height = height
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            buttonText
        })
        .buttonStyle(.glassProminent)
        .tint(btnType.onOff.btnColor)
    }
    
    /// 버튼 내부 텍스트
    private var buttonText: some View {
        Text(btnType.text)
            .font(.Subtitle3_SM)
            .foregroundStyle(btnType.onOff.textColor)
            .frame(maxWidth: .infinity)
            .frame(height: height)
    }
}

#Preview {
    MainButton(btnType: .change(onOff: .custom), action: {
        print("hello")
    })
}
