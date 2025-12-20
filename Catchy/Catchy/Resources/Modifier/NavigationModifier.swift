//
//  NavigationModifier.swift
//  Catchy
//
//  Created by euijjang97 on 12/20/25.
//

import SwiftUI

struct NavigationModifier: ViewModifier {
    
    enum Navititle {
        static let review: String = "평점, 리뷰 남기기"
    }
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(Navititle.review)
            .navigationBarTitleDisplayMode(.inline)
    }
}

extension View {
    func navigation() -> some View {
        self.modifier(NavigationModifier())
    }
}
