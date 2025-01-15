//
//  PopularCourse.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import SwiftUI
import Kingfisher

struct PopularCourse: View {
    
    let data: PopularCourseResponse
    
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
                    .frame(width: 356, height: 261)
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
                .frame(width: 156)
                .font(.Subtitle3)
                .lineLimit(nil)
                .lineSpacing(2.5)
                .foregroundStyle(Color.white)
                .padding(.bottom, 35)
                .padding(.leading, 20)
            
        })
    }
}

#Preview {
    PopularCourse(data: PopularCourseResponse(courseName: "커플들을 위한 크리스마스 데이트 코스", courseImage: "https://i.namu.wiki/i/Q3ru_aVczQgaq1Z1Ptvhktl9fM57cRQkBtn0_DWXyPvXuP3jj8zanjgG_0Cvdim3fN4cXHQ-2QAD2U7opRL9KMb6eWQzo9zpAM9jZA7xxuaMbgF0y08EFC-jcOPgKE5CawVI5g_W_Ku4GmpIL7d5RA.webp"))
}
