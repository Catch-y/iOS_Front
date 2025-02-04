//
//  CustomEmptyState.swift
//  Catchy
//
//  Created by 권용빈 on 2/5/25.
//

import SwiftUI

struct CustomEmptyStateView: View {
    let label: String
    let subLabel: String
    var spacing: CGFloat = 6
    
    var body: some View {
        VStack(spacing: spacing, content: {
            Text(label)
                .font(.Subtitle2)
                .foregroundColor(.g7)
            
            Text(subLabel)
                .font(.Body1_2)
                .foregroundColor(.g4)
        })
    }
}
#Preview {
    CustomEmptyStateView(label: "좋아요 하신 장소가 없어요!", subLabel: "마음에 드는 장소를 담아주세요.")
}
