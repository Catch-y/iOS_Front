//
//  NavigationBar.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/9/25.
//

import SwiftUI

/// 선호 조사 네비게이션
struct NavigationBar: View {
    let action: () -> Void
    let color: Color
    
    init(action: @escaping () -> Void, color: Color) {
        self.action = action
        self.color = color
    }
    
    var body: some View {
        HStack {
            Button(action: {
                action()
            }, label: {
                Image(systemName: "chevron.left")
                    .tint(color)
                    .imageScale(.large)
                    .scenePadding()
            })
            .glassEffect(.regular, in: .circle)
            
            Spacer()
        }
    }
}
