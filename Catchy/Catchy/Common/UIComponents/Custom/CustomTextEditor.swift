//
//  CustomTextEditor.swift
//  Catchy
//
//  Created by 권용빈 on 1/31/25.
//

import SwiftUI

/// SwiftUI의 ViewModifier 프로토콜을 사용하여 TextEditor의 스타일을 커스터마이징
struct CustomTextEditor: ViewModifier {
    
    /// 사용자가 입력한 텍스트 값
    @Binding var text: String
    /// 플레이스홀더로 표시할 문자열
    let placeholder: String
    /// 입력 가능한 최대 글자 수
    let maxTextCount: Int
    /// 테두리(스트로크)에 사용할 색상
    let strokeColor: Color
    /// 배경색
    let backgroundColor: Color
    
    /// 기본 이니셜라이저
    /// - Parameters:
    ///   - text: 바인딩된 텍스트
    ///   - placeholder: 플레이스홀더
    ///   - maxTextCount: 최대 글자 수
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
    
    /// 테두리 색상을 추가로 지정하는 이니셜라이저
    /// - Parameters:
    ///   - text: 바인딩된 텍스트
    ///   - placeholder: 플레이스홀더
    ///   - maxTextCount: 최대 글자 수
    ///   - strokeColor: 테두리 색상
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
    
    /// 배경 색상을 추가로 지정하는 이니셜라이저
    /// - Parameters:
    ///   - text: 바인딩된 텍스트
    ///   - placeholder: 플레이스홀더
    ///   - maxTextCount: 최대 글자 수
    ///   - backgroundColor: 배경 색상
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
    
    /// 테두리 색상과 배경 색상을 모두 지정하는 이니셜라이저
    /// - Parameters:
    ///   - text: 바인딩된 텍스트
    ///   - placeholder: 플레이스홀더
    ///   - maxTextCount: 최대 글자 수
    ///   - strokeColor: 테두리 색상
    ///   - backgroundColor: 배경 색상
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
    
    /// 실제로 TextEditor 스타일을 구성하는 뷰
    /// - Parameter content: 뷰 레이아웃
    /// - Returns: 커스텀 스타일이 적용된 뷰
    func body(content: Content) -> some View {
        content
            // 내용의 상하단 패딩
            .padding(.vertical, 10)
            // 좌우 패딩
            .padding(.horizontal, 16)
            // 아래쪽 추가 패딩
            .padding(.bottom, 20)
            // TextEditor 위에 플레이스홀더 텍스트 표시 (text가 비어있을 때만)
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
            // 자동 대문자 변환 없음
            .textInputAutocapitalization(.none)
            // 배경색 설정
            .background(backgroundColor)
            // 둥근 모서리 적용
            .clipShape(RoundedRectangle(cornerRadius: 20))
            // 텍스트 에디터 폰트 설정
            .font(.body3)
            // 텍스트 색상
            .foregroundStyle(.g7)
            // ScrollContentBackground를 숨김 처리
            .scrollContentBackground(.hidden)
            // 우측 하단에 현재 글자 수 / 최대 글자 수 표시
            .overlay(alignment: .bottomTrailing, content: {
                HStack(spacing: 0) {
                    Text("\(text.count)")
                        .font(.body3)
                        // 글자 수가 최대에 도달하면 n1, 아니면 g6
                        .foregroundColor(text.count == maxTextCount ? .n1 : .g6)
                    
                    Text(" / \(maxTextCount)")
                        .font(.body3)
                        .foregroundColor(.g4)
                }
                .padding(.trailing, 15)
                .padding(.bottom, 18)
                // onChange를 통해 입력 텍스트가 최대 글자 수를 넘지 않도록 제한
                .onChange(of: text) { newValue, oldValue in
                    if newValue.count > maxTextCount {
                        text = String(newValue.prefix(maxTextCount))
                    }
                }
            })
            // RoundedRectangle을 겹쳐서 테두리 효과
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(strokeColor, lineWidth: 1)
                    .fill(Color.clear)
            )
    }
}

extension TextEditor {
    /// 기본 커스텀 스타일 적용(테두리: g7, 배경: g1)
    func customStyleEditor(text: Binding<String>, placeholder: String, maxTextCount: Int) -> some View {
        self.modifier(CustomTextEditor(text: text, placeholder: placeholder, maxTextCount: maxTextCount))
    }
    
    /// 테두리 색상을 지정하는 커스텀 스타일
    func customStyleTipsEditor(text: Binding<String>, placeholder: String, maxTextCount: Int, border: Color) -> some View {
        self.modifier(CustomTextEditor(text: text, placeholder: placeholder, maxTextCount: maxTextCount, strokeColor: border))
    }
    
    /// 배경 색상을 지정하는 커스텀 스타일
    func customStyleTipsEditor(text: Binding<String>, placeholder: String, maxTextCount: Int, backColor: Color) -> some View {
        self.modifier(CustomTextEditor(text: text, placeholder: placeholder, maxTextCount: maxTextCount, backgroundColor: backColor))
    }
    
    /// 테두리 색상과 배경 색상을 모두 지정하는 커스텀 스타일
    func customStyleTipsEditor(text: Binding<String>, placeholder: String, maxTextCount: Int, border: Color = .clear, backColor: Color) -> some View {
        self.modifier(CustomTextEditor(text: text, placeholder: placeholder, maxTextCount: maxTextCount, strokeColor: border, backgroundColor: backColor))
    }
}

struct CustomTextEditor_Preview: PreviewProvider {
    
    @State static var inputText = ""
    
    static var previews: some View {
        // 미리보기에서 TextEditor에 customStyleEditor를 적용
        TextEditor(text: $inputText)
            .customStyleEditor(text: $inputText, placeholder: "자세히 적어주세요! 정확한 진단 결과를 받아볼 수 있어요!", maxTextCount: 150)
            .frame(width: 347, height: 204)
            .previewLayout(.sizeThatFits)
    }
}
