//
//  CourseListCard.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import SwiftUI
import Kingfisher

struct CourseGroupCard: View {
    
    var course : CourseResponseData
    
    init(course: CourseResponseData) {
        self.course = course
    }
    
    var body: some View {
        HStack(spacing: 14) {
            // TODO : - 이미지 로딩 구햔
            if let url = URL(string: course.courseImage) {
                KFImage(url)
                    .placeholder {
                        ProgressView()
                            .controlSize(.regular)
                    }.retry(maxCount: 2, interval: .seconds(2))
                    .resizable()
                    .frame(width: 133, height: 116)
                    .clipShape(RoundedRectangle(cornerRadius: 15)
                )
            }
            /// 코스 카드의 텍스트 그룹
            courseTextGroup
        }
        .padding(.vertical, 18)
        .padding(.leading, 8)
        .padding(.trailing, 9)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .s1w()
        }
    }
    
    /// 코스 카드의 텍스트 그룹
    private var courseTextGroup: some View{
        VStack(alignment: .leading, spacing: 6) {
            
            /// 코스 이름
            Text(course.courseName.customLineBreak())
                .font(.Subtitle3_SM)
                .foregroundStyle(Color.g7)
                .padding(.vertical, 2)
                .lineLimit(2)
            
            /// 카테고리 태그
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 0, maximum: 60), spacing: 5), count: 4), content: {
                ForEach(course.categorise, id: \.self) { categoryType in
                    CategoryCard(categoryType: categoryType)
                }
            })
            
            /// 코스 설명
            Text(course.courseDescription)
                .font(.body3)
                .foregroundStyle(Color.g5)
                .frame(height: 36, alignment: .topLeading)
                .lineLimit(2)
                .lineSpacing(2)
        }
        .padding(.vertical, 7)
    }
}
