//
//  View+DatePicker.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/24/25.
//

import SwiftUI

struct CatchyDatePickerStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .datePickerStyle(.wheel)
            .transition(.opacity)
    }
}

extension View {
    func catchyDatePickerStyle() -> some View {
        self.modifier(CatchyDatePickerStyle())
    }
}
