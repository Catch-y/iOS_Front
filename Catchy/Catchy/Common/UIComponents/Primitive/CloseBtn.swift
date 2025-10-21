//
//  CloseBtn.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/20/25.
//

import SwiftUI

struct CloseBtn: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(.close)
        })
        .padding()
        .glassEffect(.regular, in: .circle)
    }
}
