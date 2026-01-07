//
//  NavigationModifier.swift
//  Catchy
//
//  Created by euijjang97 on 12/20/25.
//

import SwiftUI

struct NavigationModifier: ViewModifier {
    
    let naviTitle: Navititle
    
    enum Navititle: String {
        case review = "평점, 리뷰 남기기"
        case reviewRead = "평점, 리뷰 보기"
    }
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(naviTitle.rawValue)
            .navigationBarTitleDisplayMode(.inline)
    }
}

extension View {
    func navigation(naviTitle: NavigationModifier.Navititle) -> some View {
        self.modifier(NavigationModifier(naviTitle: naviTitle))
    }
}
