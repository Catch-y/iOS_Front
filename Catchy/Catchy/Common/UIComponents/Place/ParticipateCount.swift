//
//  ParticipateCount.swift
//  Catchy
//
//  Created by euijjang97 on 12/7/25.
//

import SwiftUI

/// 하이라이트 라벨
private struct HighlightInfoLabel: View {
    
    let title: String
    let subDescrip: String
    
    var body: some View {
        HStack(spacing: 8, content: {
            Text(title)
                .font(.body3_SM)
                .foregroundStyle(.m5)
            Text(subDescrip)
                .font(.caption_SM)
                .foregroundStyle(.g5)
        })
        .padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
        .background {
            Capsule()
                .fill(.m1)
                .strokeBorder(.m3, style: .init())
        }
    }
}

/// 추천 시간대
struct RecommendTime: View {
    
    let subText: String
    
    var body: some View {
        HighlightInfoLabel(title: "추천 시간대", subDescrip: subText)
    }
}

/// 참여자 수
struct ParticipateCount: View {
    
    let count: Int
    
    var body: some View {
        HighlightInfoLabel(title: "참여자", subDescrip: "\(count)명")
    }
}
