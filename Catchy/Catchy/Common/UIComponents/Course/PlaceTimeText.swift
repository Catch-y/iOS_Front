//
//  PlaceTimeText.swift
//  Catchy
//
//  Created by LEE on 1/27/25.
//

import SwiftUI

// 장소 운영시간 텍스트
struct PlaceTimeText: View {
    let timeText: String
    
    init(timeText: String) {
        self.timeText = timeText
    }
    var body: some View {
        HStack(spacing: 5) {
            Icon.time.image.resizable()
                .frame(width: 12, height: 12)
            
            Text(timeText)
                .font(.caption)
                .foregroundStyle(.g5)
                .lineLimit(1)

        }
    }
}

