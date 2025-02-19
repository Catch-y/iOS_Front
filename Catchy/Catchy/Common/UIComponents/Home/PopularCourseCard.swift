//
//  PopularCourse.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import SwiftUI
import Kingfisher

/// 두 번째 섹션 인기 코스 카드
struct PopularCourseCard: View {
    
    let data: PopularCourseResponse
    
    //MARK: - Init
    
    init(data: PopularCourseResponse) {
        self.data = data
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading, content: {
            if let url = URL(string: data.courseImage) {
                KFImage(url)
                    .placeholder {
                        ProgressView()
                            .controlSize(.regular)
                    }.retry(maxCount: 2, interval: .seconds(2))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.screenWidth * 0.9, height: 261)
                    .overlay {
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: .black.opacity(0.5), location: 0.00),
                                Gradient.Stop(color: .black.opacity(0.1), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                    }
                    .clipShape(.rect(cornerRadius: 20))
            }
            
            Text(data.courseName)
                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                .font(.Subtitle3)
                .lineLimit(2)
                .lineSpacing(2.5)
                .foregroundStyle(Color.white)
                .padding(.bottom, 35)
                .padding(.leading, 20)
            
        })
    }
}
