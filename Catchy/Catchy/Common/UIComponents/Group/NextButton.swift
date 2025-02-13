//
//  NextButton.swift
//  Catchy
//
//  Created by 임소은 on 2/12/25.
//

import SwiftUI

struct NextButton: View {
    let title: String
    let action: () -> Void
    @State private var isButtonPressed = false
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.Subtitle3)
                .frame(maxWidth: .infinity)
                .padding()
                
        }
        .padding(.horizontal)
        .simultaneousGesture(
            TapGesture()
                .onEnded {
                    isButtonPressed = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        isButtonPressed = false
                    }
                }
        )
    }
}
