//
//  CourseListCard.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import SwiftUI
import Kingfisher

struct CourseGroupCard: View {
    
    var course : CourseResponse
    
    init(course: CourseResponse) {
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


struct CourseListCard_Preview: PreviewProvider {
    
    static var previews: some View {
        CourseGroupCard(course:
            CourseResponse(
                    courseId: 1,
                    courseType: .diy,
                    courseImage: "https://i.namu.wiki/i/sopEHIQMRri9OEV0gBMh2xV0WVKv8yKvGB_-9A14bpRhRKNKJG8xCOtiN7yUuyETF52H_aKS3gTxjFHNge6yQLV5dSL8nTzGY79D8ygwut5gTvPb52s3l2a8DIKXcahnJC6RE9L_-6uL4tTCoY5W6g.webp",
                    courseName: "한강 걷기 코스한강을 따라 걷는 코스입니다.",
                    courseDescription: "한강을 따라 걷는 코스입니다.한강을 따라 걷는 코스입니다.한강을 따라 걷는 코스입니다.한강을 따라 걷는 코스입니다.한강을 따라 걷는 코스입니다.한강을 따라 걷는 코스입니다.",
                    categorise: [.SPORT, .BAR, .CULTURELIFE, .REST, .RESTAURANT],
                    createdDate: Date()
            )
        )
        .previewLayout(.sizeThatFits)
    }
}
