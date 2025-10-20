//
//  CapusleModifier.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/29/25.
//

import SwiftUI

/// 캡슐 모디피어
struct CapsuleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 40, height: 5)
            .foregroundStyle(Color.g3)
            .glassEffect(.regular, in: .capsule)
            .safeAreaPadding(.top, 10)
    }
}

extension View {
    func capsuleStyle() -> some View {
        self.modifier(CapsuleModifier())
    }
}
