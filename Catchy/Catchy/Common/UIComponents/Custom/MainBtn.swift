//
//  MainBtn.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import SwiftUI

enum MainBtnClick {
    case on
    case off
    case custom
}

struct MainBtn: View {
    
    let text: String
    let action: () -> Void
    let width: CGFloat
    let height: CGFloat
    let onoff: MainBtnClick
    
    init(
        text: String,
        action: @escaping () -> Void,
        width: CGFloat,
        height: CGFloat,
        onoff: MainBtnClick
    ) {
        self.text = text
        self.action = action
        self.width = width
        self.height = height
        self.onoff = onoff
    }
    
    
    var body: some View {
        Button(
            action: {
                action()
            },
            label: {
                Text(text)
                    .frame(width: width, height: height)
                    .font(.buttonText)
                    .foregroundStyle(returnTextColor())
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(returnBtnColor())
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(
                                        onoff == .custom ? returnTextColor() : Color.clear,
                                        lineWidth: 1
                                    )
                            )
                    }
            })

    }
    
    func returnBtnColor() -> Color {
        switch onoff {
        case .on:
            return Color.m5
        case .off:
            return Color.g2
        case .custom:
            return Color.white
        }
    }
    
    func returnTextColor() -> Color {
        switch onoff {
        case .on:
            return Color.white
        case .off:
            return Color.g4
        case .custom:
            return Color.m5
        }
    }
}

#Preview {
    MainBtn(
        text: "Hello, World!",
        action: {
        },
        width: 370,
        height: 60,
        onoff: .on)
}
