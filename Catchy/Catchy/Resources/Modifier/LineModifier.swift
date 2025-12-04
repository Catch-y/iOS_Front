//
//  LineModifier.swift
//  Catchy
//
//  Created by Apple Coding machine on 11/25/25.
//

import SwiftUI

struct LineModifier: ViewModifier {
    let lineLimit: Int
    let lineSpacing: CGFloat
    
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.leading)
            .lineLimit(lineLimit)
            .lineSpacing(lineSpacing)
    }
}

extension View {
    func lineModifier(lineLimit: Int, lineSpacing: CGFloat) -> some View {
        self.modifier(LineModifier(lineLimit: lineLimit, lineSpacing: lineSpacing))
    }
}
