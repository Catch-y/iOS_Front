//
//  SearchTextFieldStyle.swift
//  Catchy
//
//  Created by euijjang97 on 12/5/25.
//

import SwiftUI

struct SearchTextFieldModifier: ViewModifier {
    @Binding var text: String
    var onSearch: (() -> Void)?

    func body(content: Content) -> some View {
        HStack {
            content
            Spacer()

            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.m5)
                }
            } else {
                Button(action: {
                    onSearch?()
                }) {
                    Image(.search)
                }
            }
        }
        .frame(height: 20)
        .scenePadding(.all)
        .background {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.clear)
                .strokeBorder(.m5, style: .init())
        }
    }
}

extension View {
    func searchTextFieldStyle(text: Binding<String>, onSearch: (() -> Void)? = nil) -> some View {
        self.modifier(SearchTextFieldModifier(text: text, onSearch: onSearch))
    }
}
