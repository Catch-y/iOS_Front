//
//  CustomModifier.swift
//  Catchy
//
//  Created by 정의찬 on 2/19/25.
//

import SwiftUI

extension View {
    func customDatePickerStyle() -> some View {
        self
            .datePickerStyle(.wheel)
            .labelsHidden()
            .frame(maxWidth: .infinity, minHeight: 150)
            .clipped()
            .transition(.opacity)
    }
}
