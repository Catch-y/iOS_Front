//
//  SingleButtonAlert.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/18/25.
//

import SwiftUI

struct SingleButtonAlert: View {
    
    // MARK: - Property
    let strategy: AlertStrategy
    let btnType: SingleAlertType
    
    // MARK: - Constant
    fileprivate enum SingleButtonAlert {
        static let closeBtnSize: CGSize = .init(width: 14, height: 14)
    }
    
    init(strategy: AlertStrategy, btnType: SingleAlertType) {
        self.strategy = strategy
        self.btnType = btnType
    }
    
    // MARK: - Body
    var body: some View {
        topContents
    }
    
    // MARK: - Top
    /// 상단 close 버튼 배치
    private var topContents: some View {
        HStack {
            closeView
        }
    }
    
    /// Clopse Button 텍스트 배치 분기
    @ViewBuilder
    private var closeView: some View {
        switch btnType {
        case .joinPoll:
            EmptyView()
        case .changeNickname:
            Text(strategy.title)
                .font(btnType.titleFont)
                .foregroundStyle(btnType.titleColor)
        }
        
        Spacer()
        
        Image(.close)
            .resizable()
            .frame(width: SingleButtonAlert.closeBtnSize.width, height: SingleButtonAlert.closeBtnSize.height)
    }
    
    // MARK: - Middle
}

#Preview("닉네임 변경 Alert") {
    @Previewable @State var text: String = ""
    SingleButtonAlert(strategy: ChangeNicknameStrategy(changeAction: { nickname in
        print("닉네임 변경 :\(nickname)")
    }, nickname: $text), btnType: .changeNickname)
}

#Preview("투표 참여 Alert") {
    SingleButtonAlert(strategy: GenerateVotwStrategy(joinPoll: {
        print("투표 참여")
    }), btnType: .joinPoll)
}

