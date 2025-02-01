//
//  placeReviewButton.swift
//  Catchy
//
//  Created by LEE on 1/27/25.
//

import SwiftUI

// 장소 리뷰 버튼 
struct placeReviewButton: View {
    
    let reviewCount: Int
    
    init(reviewCount: Int) {
        self.reviewCount = reviewCount
    }
    var body: some View {
        HStack(spacing: 6) {
            Icon.review.image.fixedSize()
            
            Text("리뷰 \(reviewCount)개")
                .font(.caption)
                .foregroundStyle(.g5)
                .lineLimit(1)

            
            Icon.rightChevron.image.resizable()
                .frame(width: 4, height: 8)
        }
    }
}

#Preview {
    placeReviewButton(reviewCount: 423)
}
