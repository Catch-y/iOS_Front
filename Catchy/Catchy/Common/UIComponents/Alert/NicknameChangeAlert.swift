//
//  SingleButtonAlert.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/18/25.
//

import SwiftUI

struct NicknameChangeAlert: View {
    
    // MARK: - Property
    @Environment(\.dismiss) var dismiss
    let strategy: AlertStrategy
    let btnOnOff: Bool
    
    // MARK: - Constant
    fileprivate enum SingleButtonAlert {
        static let spacerValue: (CGFloat, CGFloat) = (19, 25)
        static let mainPadding: EdgeInsets = .init(top: 18, leading: 0, bottom: 20, trailing: 0)
        static let btnPadding: EdgeInsets = .init(top: 8, leading: 18, bottom: 8, trailing: 18)
        static let bottomFieldAreaPadding: CGFloat = 65
        
        static let mainBtnHeight: CGFloat = 36
        
        static let closeBtnSize: CGSize = .init(width: 14, height: 14)
        static let conerRadius: CGFloat = 20
        
        static let duplicatedText: String = "중복확인"
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: .zero, content: {
            topContents
            Spacer().frame(height: SingleButtonAlert.spacerValue.0)
            Divider()
                .foregroundStyle(.g2)
            Spacer().frame(height: SingleButtonAlert.spacerValue.1)
            bottomContents
        })
        .padding(SingleButtonAlert.mainPadding)
        .background {
            RoundedRectangle(cornerRadius: SingleButtonAlert.conerRadius)
                .fill(.white)
                .frame(maxWidth: .infinity)
        }
    }
    
    // MARK: - Top
    /// 상단 close 버튼 배치
    private var topContents: some View {
        ZStack(alignment: .trailing, content: {
            HStack {
                Spacer()
                Text(strategy.title)
                    .font(.body2)
                    .foregroundStyle(.g7)
                
                Spacer()
            }
            
            CloseBtn(action: {
                dismiss()
            })
        })
    }
    
    // MARK: - Middle
    /// 닉네임 변경하기 중간 뷰
    private var middleContents: some View {
        HStack {
            middleTextField
            Spacer()
            duplicatedBtn
        }
    }
    /// 닉네임 입력 텍스트 필드
    @ViewBuilder
    private var middleTextField: some View {
        if let textBinding = strategy.textBinding {
            TextField("", text: textBinding)
                .textFieldStyle(CatchyTextFieldStyle())
        }
    }
    
    /// 중복확인 버튼
    private var duplicatedBtn: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: DefaultConstants.animationTime)) {
                strategy.secondaryAction()
            }
        }, label: {
            Text(SingleButtonAlert.duplicatedText)
                .font(.caption_SM)
                .foregroundStyle(.g4)
                .padding(SingleButtonAlert.btnPadding)
        })
        .glassEffect(.regular, in: .rect(cornerRadius: SingleButtonAlert.conerRadius))
    }
    
    // MARK: - Bottom
    /// 변경하기 버튼 + 닉네임 작성 스택-
    private var bottomContents: some View {
        VStack {
            middleContents
            Spacer().frame(height: SingleButtonAlert.spacerValue.1)
            bottomChangeBtn
        }
        .safeAreaPadding(.horizontal, SingleButtonAlert.bottomFieldAreaPadding)
    }
    
    /// 하단 변경하기 버튼
    @ViewBuilder
    private var bottomChangeBtn: some View {
        if let btn = strategy.buttons?.first {
            MainButton(btnType: btn, height: SingleButtonAlert.mainBtnHeight,  action: {
                strategy.primaryAction()
            })
            .disabled(!btnOnOff)
        }
    }
}

#Preview {
    @Previewable @State var onOff: Bool = false
    @Previewable @State var text: String = "11"
    
    NicknameChangeAlert(strategy: ChangeNicknameStrategy(buttons: [.change(onOff: onOff ? .on : .off)], changeAction: { _ in
        print("변경 완료")
    }, duplicateAction: {
        onOff.toggle()
    }, nickname: $text), btnOnOff: onOff)
}
