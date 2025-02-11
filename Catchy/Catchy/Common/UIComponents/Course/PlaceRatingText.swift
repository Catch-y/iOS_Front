//
//  PlaceRatingText.swift
//  Catchy
//
//  Created by LEE on 1/27/25.
//

import SwiftUI

/// 장소 평점 텍스트
struct PlaceRatingText: View {
    
    let rating: String
    
    init(rating: Double) {
        let roundedValue = round(rating * 10) / 10
        self.rating = String(format: "%.1f", roundedValue)
    }
    
    var body: some View {
        HStack(spacing: 5) {
            Icon.star.image.fixedSize()
            
            Text("평점 \(rating)")
                .font(.caption)
                .foregroundStyle(.g5)
                .lineLimit(1)

        }
    }
    
}

#Preview {
    PlaceRatingText(rating: 4.3)
}
