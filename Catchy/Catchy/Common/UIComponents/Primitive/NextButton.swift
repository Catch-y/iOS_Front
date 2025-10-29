//
//  NextButton.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/22/25.
//

import SwiftUI

struct NextButton: View {
    let action: () -> Void
    let value: Bool
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: "chevron.right")
                .tint(.main)
                .imageScale(.large)
                .scenePadding()
                .symbolEffect(.bounce.up, value: value)
        })
    }
}
