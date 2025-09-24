//
//  View+Keyboard.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/18/25.
//

import Foundation
import SwiftUI

extension View {
    func keyboardToolbar(downAction: @escaping () -> Void) -> some View {
        self.toolbar(content: {
            ToolbarItemGroup(placement: .keyboard, content: {
                HStack(content: {
                    Spacer()
                })
            })
            ToolbarItem(placement: .keyboard, content: {
                Button(action: {
                    downAction()
                }, label: {
                    Image(systemName: "chevron.down")
                        .renderingMode(.template)
                        .foregroundStyle(Color.g7)
                })
            })
        })
    }
}
