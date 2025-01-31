//
//  CustomTextEditor.swift
//  Catchy
//
//  Created by 권용빈 on 1/31/25.
//

import SwiftUI

struct CustomTextEditor: ViewModifier {
    
    @Binding var text: String
    let placeholder: String
    let maxTextCount: Int
    let strokeColor: Color
    let backgroundColor: Color
    
    init(text: Binding<String>,
         placeholder: String,
         maxTextCount: Int
    ) {
        self._text = text
        self.placeholder = placeholder
        self.maxTextCount = maxTextCount
        self.strokeColor = .g7
        self.backgroundColor = .g1
    }
    
    init(
        text: Binding<String>,
        placeholder: String,
        maxTextCount: Int,
        strokeColor: Color
    ) {
        self._text = text
        self.placeholder = placeholder
        self.maxTextCount = maxTextCount
        self.strokeColor = strokeColor
        self.backgroundColor = .g1
    }
    
    init(text: Binding<String>,
         placeholder: String,
         maxTextCount: Int,
         backgroundColor: Color
    ) {
        self._text = text
        self.placeholder = placeholder
        self.maxTextCount = maxTextCount
        self.strokeColor = .g7
        self.backgroundColor = backgroundColor
    }
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            .background(alignment: .topLeading, content: {
                if text.isEmpty {
                    Text(placeholder)
                        .lineSpacing(10)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 20)
                        .font(.body2)
                        .foregroundStyle(.g4)
                }
            })
            .textInputAutocapitalization(.none)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .font(.body3)
            .foregroundStyle(.g7)
            .scrollContentBackground(.hidden)
            .overlay(alignment: .bottomTrailing, content: {
                HStack(spacing: 0) {
                    Text("\(text.count)")
                        .font(.body3)
                        .foregroundColor(text.count == maxTextCount ? .n1: .g6)
                    
                    Text(" / \(maxTextCount)")
                        .font(.body3)
                        .foregroundColor(.g4)
                }
                .padding(.trailing, 15)
                .padding(.bottom, 10)
                .onChange(of: text) { newValue, oldValue in
                    if newValue.count > maxTextCount {
                        text = String(newValue.prefix(maxTextCount))
                    }
                }
            })
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(strokeColor, lineWidth: 1)
                    .fill(Color.clear)
            )
    }
}

extension TextEditor {
    func customStyleEditor(text: Binding<String>, placeholder: String, maxTextCount: Int) -> some View {
        self.modifier(CustomTextEditor(text: text, placeholder: placeholder, maxTextCount: maxTextCount))
    }
    
    func customStyleTipsEditor(text: Binding<String>, placeholder: String, maxTextCount: Int, border: Color) -> some View {
        self.modifier(CustomTextEditor(text: text, placeholder: placeholder, maxTextCount: maxTextCount, strokeColor: border))
    }
    
    func customStyleTipsEditor(text: Binding<String>, placeholder: String, maxTextCount: Int, backColor: Color) -> some View {
        self.modifier(CustomTextEditor(text: text, placeholder: placeholder, maxTextCount: maxTextCount, backgroundColor: backColor))
    }
}

struct CustomTextEditor_Preview: PreviewProvider {
    
    @State static var inputText = ""
    
    static var previews: some View {
        TextEditor(text: $inputText)
            .customStyleEditor(text: $inputText, placeholder: "자세히 적어주세요! 정확한 진단 결과를 받아볼 수 있어요!ㄴㅇㄹㄴㄹㄴㅇㄹㅇㄴㄹㄴㅇㄹㄴㅇㄹㄴㅇㄹㄴㅇ", maxTextCount: 150)
            .frame(width: 347, height: 204)
            .previewLayout(.sizeThatFits)
    }
}
