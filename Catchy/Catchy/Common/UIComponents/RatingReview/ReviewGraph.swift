//
//  ReviewGraph.swift
//  Catchy
//
//  Created by 권용빈 on 1/22/25.
//

import SwiftUI

struct ReviewGraph: View {
    
    let score: Int
    let personCount: Int
    let totalPersonCount: Int
    
    init(score: Int, personCount: Int, totalPersonCount: Int) {
        self.score = score
        self.personCount = personCount
        self.totalPersonCount = totalPersonCount
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 10, content: {
            Text("\(score)점")
                .frame(width: 13, alignment: .leading)
                .font(.caption2)
                .foregroundColor(.g5)
            
            ProgressView(value: Double(personCount) / Double(totalPersonCount), total: 1.0)
                .progressViewStyle(.linear)
                .background(Color.g2)
                .tint(Color.m5)
                .frame(maxWidth: 80, maxHeight: 8)
                .scaleEffect(x: 1.0, y: 2.0, anchor: .center)
                .clipShape(RoundedRectangle(cornerRadius: 5.5))
                

            
            if personCount <= 999 {
                Text("\(personCount)명")
                    .font(.caption2)
                    .foregroundColor(.g4)
            }
            else {
                Text("999+명")
                    .font(.caption2)
                    .foregroundColor(.g4)
            }
                
        })
        .frame(width: 140, alignment: .leading)
    }
}

struct ResultReviewGraph_Previews : PreviewProvider {
    static var previews: some View {
        ReviewView(container: DIContainer())
            .environmentObject(DIContainer())
    }
}

