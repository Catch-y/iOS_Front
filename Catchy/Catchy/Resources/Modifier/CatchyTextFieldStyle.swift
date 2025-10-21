//
//  TextFieldStyle.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/21/25.
//

import Foundation
import SwiftUI

struct CatchyTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical, 10)
            .overlay(alignment: .bottom, content: {
                Rectangle()
                    .fill(.g2)
                    .frame(height: 1)
            })
    }
}
