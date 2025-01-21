//
//  CourseListCard.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import SwiftUI

struct CourseListCard: View {
    
    var course : CourseListResponse
    
    init(course: CourseListResponse) {
        self.course = course
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .s1w()
                .frame(width: 370, height: 158)
            
            HStack{
                Image(course.courseImage)
                    .frame(width: 133, height: 116)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                VStack(alignment: .leading){
                    
                    /// 코스 이름
                    Text(course.courseName)
                        .font(.Subtitle3_SM)
                        .padding(.bottom, 6)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    /// 카테고리 태그
                    LazyVGrid(
                        columns: [
                            GridItem(.fixed(50), spacing: 5, alignment: .leading),
                            GridItem(.fixed(50), spacing: 5, alignment: .leading),
                            GridItem(.fixed(50), spacing: 5, alignment: .leading)
                        ],
                        alignment: .leading,
                        spacing: 5
                        ) {
                            ForEach(course.categorise, id: \.self) { categoryType in
                                CategoryCard(categoryType: categoryType)
                            }
                        }
                        .padding(.bottom, 21)
                        .frame(width: 206, height: 40, alignment: .topLeading)
                    
                    /// 코스 설명
                    Text(course.courseDescription)
                        .font(.body3)
                        .foregroundStyle(Color.g5)
                        .frame(width: 150, height: 36, alignment: .topLeading)
                        .lineLimit(2)
                        .truncationMode(.tail)
                }
            }
        }
    

    }
}


#Preview {
    CourseListCard(course:
        CourseListResponse(
                courseId: 1,
                courseType: .diy,
                courseImage: "image1.jpg",
                courseName: "한강 걷기 코스",
                courseDescription: "한강을 따라 걷는 코스입니다.",
                categorise: [.SPORT, .BAR, .CULTURELIFE, .REST, .RESTAURANT],
                createdDate: Date()
        )
    )
}
