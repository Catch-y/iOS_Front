//
//  StarPoint.swift
//  Catchy
//
//  Created by 정의찬 on 1/16/25.
//

import SwiftUI

struct StarPoint: View {
    
    let point: Double
    
    var body: some View {
        HStack(spacing: 5, content: {
            Icon.star.image
                .fixedSize()
            
            Text("평점 \(String(format: "%.1f", point))")
                .font(.caption)
                .foregroundStyle(Color.g4)
        })
    }
}
