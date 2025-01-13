//
//  SignUpView.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewModel: SignUpViewModel
    @EnvironmentObject var container: DIContainer
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        Text("hello")
    }
    
    private var topTitle: some View {
        Text("프로필을 설정하고 \n회원 가입을 완료해주세요")
            .font(.Subtitle2)
            .lineSpacing(3.3)
            .foregroundStyle(Color.g7)
            .kerning(-0.32)
    }
}

extension SignUpView {
    private func makeTextFieldTitle(_ title: String) -> Text {
        return Text(title)
            .font(.caption1)
            .foregroundStyle(Color.g4)
    }
    
    private func makeTextField(_ place: String, value: Binding<String>) -> some View {
        return VStack(spacing: 5, content: {
            TextField(place, text: value)
                .textFieldStyle(PlainTextFieldStyle())
                .font(.inputText)
                .foregroundStyle(Color.g7)
                .tint(Color.black)
            
            Divider()
                .frame(height: 1)
                .background(Color.g2)
        })
    }
}
