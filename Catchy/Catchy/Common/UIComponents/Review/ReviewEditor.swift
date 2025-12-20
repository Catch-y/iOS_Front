//
//  ReviewEditor.swift
//  Catchy
//
//  Created by euijjang97 on 12/20/25.
//

import SwiftUI

struct ReviewEditor: View, Equatable {
    
    // MARK: - Property
    @Binding var text: String
    
    var isFocused: FocusState<Bool>.Binding
    let limit: Int
    let placeholderText: String
    let hintText: String
    
    // MARK: - Equatable
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.text == rhs.text &&
        lhs.limit == rhs.limit &&
        lhs.placeholderText == rhs.placeholderText
    }
    
    // MARK: - Constant
    fileprivate enum EditorConstants {
        static let defaultLimit: Int = 300
        static let minHeight: CGFloat = 200
        static let contentPadding: CGFloat = 20
        static let lineSpacing: CGFloat = 5
        static let placeholderHPadding: CGFloat = 4
        static let placeholderVPadding: CGFloat = 8
        static let bottomSpacing: CGFloat = 20
        
        static let defaultPlaceholder = """
             방문한 장소에 대한 소중한 리뷰를 남겨 보세요!
             작성한 리뷰는 다른 사용자들에게 유용한 정보를 제공하며,
             다음 방문을 위한 기록으로도 활용할 수 있습니다.
                                                                                                                                                                       
             [리뷰에 포함되면 좋은 내용]
             - 장소의 분위기와 특징
             - 추천하거나 주의할 점
             - 기억에 남는 특별한 경험
                                                                                                                                                                       
             여러분의 리뷰가 더 나은 코스를 만드는 데 큰 도움이 됩니다!
             """
        
        static let defaultHint = "장소의 분위기나 특징은 어땠나요?"
    }
    
    // MARK: - Init
    init(
        text: Binding<String>,
        isFocused: FocusState<Bool>.Binding,
        limit: Int = EditorConstants.defaultLimit,
        placeholderText: String = EditorConstants.defaultPlaceholder,
        hintText: String = EditorConstants.defaultHint
    ) {
        self._text = text
        self.isFocused = isFocused
        self.limit = limit
        self.placeholderText = placeholderText
        self.hintText = hintText
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: .zero, content: {
            textEditorSection
            Spacer().frame(height: EditorConstants.bottomSpacing)
            bottomInfoSection
        })
        .padding(EditorConstants.contentPadding)
        .background {
            RoundedRectangle(cornerRadius: EditorConstants.contentPadding)
                .fill(.g2)
        }
        .onTapGesture {
            isFocused.wrappedValue = true
        }
    }
}

// MARK: - SubViews
extension ReviewEditor {
    private var textEditorSection: some View {
        ZStack(alignment: .topLeading, content: {
            placeholderView
            editorView
        })
        .frame(minHeight: EditorConstants.minHeight, maxHeight: 313)
    }
    
    @ViewBuilder
    private var placeholderView: some View {
        if text.isEmpty && !isFocused.wrappedValue {
            Text(placeholderText)
                .font(.body2)
                .foregroundStyle(.g4)
                .lineSpacing(EditorConstants.lineSpacing)
                .padding(.horizontal, EditorConstants.placeholderHPadding)
                .padding(.vertical, EditorConstants.placeholderVPadding)
                .allowsHitTesting(false)
        }
    }
    
    private var editorView: some View {
        TextEditor(text: $text)
            .scrollContentBackground(.hidden)
            .background(.clear)
            .font(.body2)
            .foregroundStyle(.g7)
            .lineSpacing(EditorConstants.lineSpacing)
            .focused(isFocused)
            .onChange(of: text, { _, new in
                enforeceCharacterLimit(new)
            })
    }
    
    private var bottomInfoSection: some View {
        HStack {
            Text(hintText)
                .font(.body3)
                .foregroundStyle(.sub)
            
            Spacer()
            
            characterCount
        }
    }
    
    private var characterCount: some View {
        HStack(spacing: 2, content: {
            Text("\(text.count)")
                .foregroundStyle((text.count == 300) ? .n1 : .g5)
            Text("/")
                .foregroundStyle(.g5)
            Text("\(limit)")
                .foregroundStyle(.g5)
        })
        .font(.body3)
    }
}

extension ReviewEditor {
    private func enforeceCharacterLimit(_ new: String) {
        if new.count > limit {
            text = String(new.prefix(limit))
            HapticManager.notification(.warning)
        }
    }
}

extension HapticManager {
    static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
}
