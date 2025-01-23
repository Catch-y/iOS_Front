//
//  ReviewGraph.swift
//  Catchy
//
//  Created by 권용빈 on 1/22/25.
//

import SwiftUI

struct ReviewGraph: View {
    
    /// 점수(1~5점), 해당 점수를 준 사람 수, 전체 리뷰 작성자 수
    let score: Int
    let personCount: Int
    let totalPersonCount: Int
    
    /// 초기화 메서드
    /// - Parameters:
    ///   - score: 점수 값
    ///   - personCount: 해당 점수를 준 사람 수
    ///   - totalPersonCount: 전체 리뷰 작성자 수
    init(score: Int, personCount: Int, totalPersonCount: Int) {
        self.score = score
        self.personCount = personCount
        self.totalPersonCount = totalPersonCount
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 10, content: {
            /// 점수 텍스트 표시
            Text("\(score)점")
                .frame(width: 13, alignment: .leading)
                .font(.caption2)
                .foregroundColor(.g5)
            
            /// 진행 상태 표시 바 (ProgressView)
            ProgressView(value: Double(personCount) / Double(totalPersonCount), total: 1.0)
                .progressViewStyle(.linear)
                .background(Color.g2)
                .tint(Color.m5)
                .frame(width: 80, height: 8)
                .scaleEffect(x: 1.0, y: 2.0, anchor: .center)
                .clipShape(RoundedRectangle(cornerRadius: 5.5))
                

            /// 특정 점수를 준 사람 수 표시 (최대 999명으로 제한)
            Text(returnCount(count: personCount))
                .font(.caption2)
                .foregroundColor(.g4)
                .frame(width: 28, alignment: .leading)
        })
    }
    
    func returnCount(count: Int) -> String {
        if count <= 999 {
            return "\(count)명"
        } else {
            return "999+"
        }
    }
}

struct ResultReviewGraph_Previews : PreviewProvider {
    static var previews: some View {
        ReviewGraph(score: 1, personCount: 20000000, totalPersonCount: 12)
            .previewLayout(.sizeThatFits)
    }
}

