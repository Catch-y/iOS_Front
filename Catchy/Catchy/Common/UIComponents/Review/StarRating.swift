//
//  StarRating.swift
//  Catchy
//
//  Created by 권용빈 on 1/23/25.
//

import SwiftUI

/// 별점 표시 뷰
struct StarRating: View {
    let rating: Double

    init(rating: Double) {
        self.rating = rating
    }
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5, id: \.self) { index in
                if index < Int(rating.rounded()) {
                    Icon.star.image
                        .padding(4)
                } else {
                    Icon.emptyStar.image
                        .padding(4)
                }
            }
        }
        .frame(width: 118)
    }
}


struct StarRating_Previews: PreviewProvider {
    static var previews: some View {
        StarRating(rating: 2.7)
            .previewLayout(.sizeThatFits)
    }
}
   
