//
//  CustomTextField.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    @FocusState private var isTextFocused: Bool
    
    let keyboardType: UIKeyboardType
    let onSubmit: (() -> Void)?
    let searchTextField: SearchTextField
    
    init(
        keyboardType: UIKeyboardType = .default,
        text: Binding<String>,
        isTextFocused: Bool = false,
        onSubmit: (() -> Void)? = nil,
        searchTextField: SearchTextField
    ) {
        self.keyboardType = keyboardType
        self._text = text
        self.onSubmit = onSubmit
        self.searchTextField = searchTextField
    }
    
    var body: some View {
        ZStack(alignment: .center, content: {
            outLineTextField
            
            placeholderInField
        })
        .onTapGesture {
            isTextFocused = false
        }
        .ignoresSafeArea(.keyboard)
        .frame(width: searchTextField.textFieldWidth(), height: searchTextField.textFieldHeight(), alignment: .center)
        .focused($isTextFocused)
        .background(searchTextField.textFieldBgColor())
        .clipShape(.rect(cornerRadius: 30))
        .overlay(content: {
            RoundedRectangle(cornerRadius: 30)
                .inset(by: 0.5)
                .stroke(searchTextField.textFieldBorderColor(), lineWidth: 1)
                .frame(width: searchTextField.textFieldWidth())
        })
    }
    
    private var placeholderInField: some View {
        HStack(spacing: 2, content: {
            if text.isEmpty && !isTextFocused {
                Text(searchTextField.placeholderText())
                    .font(searchTextField.placeholderFont())
                    .foregroundStyle(Color.g3)
                    .allowsHitTesting(false)
                    .padding(.vertical, 15)
            }
            
            Spacer()
            
            Icon.search.image
                .fixedSize()
        })
        .frame(width: searchTextField.placeholderWidth(), height: searchTextField.placeholderHeight(), alignment: .leading)
        .onTapGesture {
            isTextFocused = true
        }
    }
    
    private var outLineTextField: some View {
        HStack(content: {
            TextField("", text: $text, axis: .horizontal)
                .frame(maxWidth: searchTextField.textFieldWidth() - 35, maxHeight: searchTextField.textFieldHeight(), alignment: .leading)
                .font(searchTextField.textFieldFont())
                .foregroundStyle(Color.g7)
                .focused($isTextFocused)
                .background(Color.clear)
                .padding(.leading, 10)
                .onSubmit {
                    onSubmit?()
                }
                .onTapGesture {
                    if !isTextFocused {
                        text = ""
                        isTextFocused = true
                    }
                }
            
            Spacer()
        })
        
    }
}

struct CustomeTextField_Preview: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""), searchTextField: .homeView)
    }
}
