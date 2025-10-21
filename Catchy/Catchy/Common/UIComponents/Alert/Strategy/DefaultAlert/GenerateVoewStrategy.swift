//
//  GenerateVoewStrategy.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/18/25.
//

import SwiftUI

/// 투표 생성 전략 패턴
struct GenerateVotwStrategy: AlertStrategy {
    let title: String = "투표가 생성되었습니다! \n지금 바로 투표에 참여해보세요!"
    let message: String? = nil
    let icon: Image? = nil
    let buttons: [MainBtnType]? = [.voteComplete(onOff: .on)]
    var textBinding: Binding<String>? = nil
    let joinPoll: () -> Void
    
    func primaryAction() {
        joinPoll()
    }
    
    func secondaryAction() {}
}
