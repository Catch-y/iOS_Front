//
//  TwoButtonAlert.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/18/25.
//

import SwiftUI

struct TwoButtonAlert: View {
    
    // MARK: - Property
    let strategy: AlertStrategy
    
    // MARK: - Constants
    fileprivate enum TwoButtonAlertConstant {
        static let middleVspacing: CGFloat = 1
        static let bottomHspacing: CGFloat = 15
        static let mainPadding: EdgeInsets = .init(top: 24, leading: 41, bottom: 29 , trailing: 42)
        
        static let spacerHegiht: (CGFloat, CGFloat) = (13, 22)
        static let bgHeight: CGFloat = 192
        
        static let cornerRadius: CGFloat = 20
        static let deleteText: String = "삭제"
    }
    
    // MARK: - Init
    init(strategy: AlertStrategy) {
        self.strategy = strategy
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: .zero, content: {
            Image(.warningIntro)
            Spacer().frame(height: TwoButtonAlertConstant.spacerHegiht.0)
            middleContents
            Spacer().frame(height: TwoButtonAlertConstant.spacerHegiht.1)
            bottomContents
        })
        .padding(TwoButtonAlertConstant.mainPadding)
        .background {
            RoundedRectangle(cornerRadius: TwoButtonAlertConstant.cornerRadius)
                .fill(Color.white)
                .frame(maxWidth: .infinity)
        }
    }
    
    // MARK: - Middle
    /// 중간 Alert 제목 및 메시지
    private var middleContents: some View {
        VStack(spacing: TwoButtonAlertConstant.middleVspacing, content: {
            Text(title)
                .font(.Subtitle3_SM)
                .foregroundStyle(.g7)
            
            if let message = strategy.message {
                Text(message)
                    .font(.body3)
                    .foregroundStyle(.g3)
            }
        })
    }
    
    /// Alert 제목 Attr 속성
    private var title: AttributedString {
        var str = AttributedString(strategy.title)
        if let range = str.range(of: TwoButtonAlertConstant.deleteText) {
            str[range].foregroundColor = .m6
            str[range].font = .Subtitle3_SM
        }
        return str
    }
    
    // MARK: - Bottom
    /// 하단 버튼 취소 & 확인 버튼
    @ViewBuilder
    private var bottomContents: some View {
        if let btns = strategy.buttons {
            HStack(spacing: TwoButtonAlertConstant.bottomHspacing, content: {
                ForEach(btns, id: \.self) { btn in
                    MainButton(btnType: btn, height: 38,  action: {
                        buttonAction(btn)
                    })
                }
            })
        }
    }
    
    func buttonAction(_ btn: MainBtnType) -> Void {
        switch btn {
        case .cancel(onOff: .off):
            strategy.secondaryAction()
        case .check(onOff: .on):
            strategy.primaryAction()
        default: break
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TwoButtonAlert(strategy: ReviewDeleteStrategy(confirmAction: {
        print("취소")
    }, cancelAction: {
        print("확인")
    }))
}
