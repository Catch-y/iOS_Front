//
//  PollStrategy.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/18/25.
//

import SwiftUI

/// 투표 전략 패턴
struct PollStrategy: GuideStrategy {
    let sections: [GuideSection] = [
        .init(title: "코스에 추가하고 싶은 \n카테고리에 투표해주세요", description: "중복투표도 가능합니다.")
    ]
    let categoryType: [CategoryType] = CategoryType.allCases

    let buttonType: MainBtnType
}
