//
//  ReviewComponent.swift
//  Catchy
//
//  Created by 정의찬 on 1/16/25.
//

import SwiftUI

struct ReviewComponent: View {
    
    let reviewCount: Int
    
    var body: some View {
        HStack(spacing: 6, content: {
            Icon.review.image
                .fixedSize()
            Text("리뷰 \(reviewCount)개")
                .font(.caption)
                .foregroundStyle(Color.g4)
            
            Icon.rightChevron.image
                .fixedSize()
        })
    }
}
