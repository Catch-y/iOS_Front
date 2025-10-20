//
//  LoadingGenerateStrategy.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/18/25.
//

import SwiftUI

/// 로딩 중 전략 패턴
struct LoadingGenerateStrategy: AlertStrategy {
    let title: String = "입력하신 정보를 토대로 \n코스를 생성 중이에요!"
    let message: String? = "잠시만 기다려주세요."
    let icon: Image? = nil
    let buttons: [MainBtnType]? = nil
    
    func primaryAction() {}
    
    func secondaryAction() {}
}
