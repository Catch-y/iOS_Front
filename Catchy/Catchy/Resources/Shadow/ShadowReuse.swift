//
//  SwiftAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation
import SwiftUI

struct S1W: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 0)
    }
}

struct S2T: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.6), radius: 3, x: 0, y: 0)
    }
}

struct S3I: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.3), radius: 2.5, x: 0, y: 0)
    }
}

struct S4B: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
    }
}

struct EmptyModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func s1w() -> some View {
        self.modifier(S1W())
    }
    
    func s2t() -> some View {
        self.modifier(S2T())
    }
    
    func s3i() -> some View {
        self.modifier(S3I())
    }
    
    func s4b() -> some View {
        self.modifier(S4B())
    }
    
    func empty() -> some View {
        self.modifier(EmptyModifier())
    }
}
