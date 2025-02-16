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
    
    /// 텍스트 에디터 생성자
    /// - Parameters:
    ///   - text: 에디터에 입력할 텍스트
    ///   - placeholder: 에디터의 기본 텍스트
    ///   - maxTextCount: 에디터에 최대 입력 개수
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
    
    
    /// 텍스트 에디터 생성자(테두리 색 포함)
    /// - Parameters:
    ///   - text: 에디터에 입력할 텍스트
    ///   - placeholder: 에디터의 기본 텍스트
    ///   - maxTextCount: 에디터의 최대 입력 글자 수
    ///   - strokeColor: 에디터의 테두리 색상
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
    
    /// 텍스트 에디터 생성자(배경 색 포함)
    /// - Parameters:
    ///   - text: 에디터에 입력할 텍스트
    ///   - placeholder: 에디터의 기본 텍스트
    ///   - maxTextCount: 에디터의 최대 입력 글자 수
    ///   - backgroundColor: 에디터의 배경 색상
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
    
    /// 텍스트 에디터 생성자(테두리 색, 배경 색 포함)
    /// - Parameters:
    ///   - text: 에디터에 입력할 텍스트
    ///   - placeholder: 에디터의 기본 텍스트
    ///   - maxTextCount: 에디터의 최대 입력 글자 수
    ///   - strokeColor: 에디터의 테두리 색상
    ///   - backgroundColor: 에디터의 배경 배경 색상
    init(text: Binding<String>,
         placeholder: String,
         maxTextCount: Int,
         strokeColor: Color,
         backgroundColor: Color
    ) {
        self._text = text
        self.placeholder = placeholder
        self.maxTextCount = maxTextCount
        self.strokeColor = strokeColor
        self.backgroundColor = backgroundColor
    }
    
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
            .background(alignment: .topLeading, content: {
                if text.isEmpty {
                    Text(placeholder)
                        .lineSpacing(10)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 20)
                        .font(.body2)
                        .foregroundStyle(.g3)
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
                .padding(.bottom, 18)
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

// MARK: - Extension
extension TextEditor {
    /// 텍스트 에디터에 적용될 속성
    /// - Parameters:
    ///   - text: 에디터에 입력할 텍스트
    ///   - placeholder: 에디터의 기본 텍스트
    ///   - maxTextCount: 에디터의 최대 글자 수
    /// - Returns: 텍스트 에디터
    func customStyleEditor(text: Binding<String>, placeholder: String, maxTextCount: Int) -> some View {
        self.modifier(CustomTextEditor(text: text, placeholder: placeholder, maxTextCount: maxTextCount))
    }
    
    /// 텍스트 에디터에 적용될 속성
    /// - Parameters:
    ///   - text: 에디터에 입력할 텍스트
    ///   - placeholder: 에디터의 기본 텍스트
    ///   - maxTextCount: 에디터의 최대 글자 수
    ///   - border: 에디터의 테두리 색상
    /// - Returns: 텍스트 에디터
    func customStyleTipsEditor(text: Binding<String>, placeholder: String, maxTextCount: Int, border: Color) -> some View {
        self.modifier(CustomTextEditor(text: text, placeholder: placeholder, maxTextCount: maxTextCount, strokeColor: border))
    }
    
    /// 텍스트 에디터에 적용될 속성
    /// - Parameters:
    ///   - text: 에디터에 입력할 텍스트
    ///   - placeholder: 에디터의 기본 텍스트
    ///   - maxTextCount: 에디터의 최대 글자 수
    ///   - backColor: 에디터의 배경 색상
    /// - Returns: 텍스트 에디터
    func customStyleTipsEditor(text: Binding<String>, placeholder: String, maxTextCount: Int, backColor: Color) -> some View {
        self.modifier(CustomTextEditor(text: text, placeholder: placeholder, maxTextCount: maxTextCount, backgroundColor: backColor))
    }
    
    /// 텍스트 에디터에 적용될 속성
    /// - Parameters:
    ///   - text: 에디터에 입력할 텍스트
    ///   - placeholder: 에디터의 기본 텍스트
    ///   - maxTextCount: 에디터의 최대 글자 수
    ///   - border: 에디터의 테두리 색상
    ///   - backColor: 에디터의 배경 색상
    /// - Returns: 텍스트 에디터
    func customStyleTipsEditor(text: Binding<String>, placeholder: String, maxTextCount: Int, border: Color = .clear, backColor: Color) -> some View {
        self.modifier(CustomTextEditor(text: text, placeholder: placeholder, maxTextCount: maxTextCount, strokeColor: border, backgroundColor: backColor))
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
