//
//  ChangeNicknameStrategy.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/18/25.
//

import Foundation
import SwiftUI

/// 이름 변경창 전략 패턴
struct ChangeNicknameStrategy: AlertStrategy {
    let title: String = "변경할 닉네임을 입력해주세요"
    let message: String? = nil
    let icon: Image? = nil
    let buttons: [MainBtnType]? =  [.change(onOff: .on)]
    
    let changeAction: (String) -> Void
    @Binding var nickname: String
    
    func primaryAction() {
        changeAction(nickname)
    }
    
    func secondaryAction() {}
}
