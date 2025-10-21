//
//  ReviewDeleteStrategy.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/18/25.
//

import SwiftUI

/// 리뷰 전략 패턴
struct ReviewDeleteStrategy: AlertStrategy {
    let title: String = "리뷰를 삭제 하시겠습니까?"
    let message: String? = "리뷰를 삭제하면 다시 복구할 수 없어요."
    let icon: Image? = Image(.warningIntro)
    let buttons: [MainBtnType]? = [.cancel(onOff: .off), .check(onOff: .on)]
    var textBinding: Binding<String>? = nil
    
    let confirmAction: () -> Void
    let cancelAction: () -> Void
    
    func primaryAction() {
        confirmAction()
    }
    
    func secondaryAction() {
        cancelAction()
    }
}
