//
//  CosCard.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import SwiftUI
import Kingfisher

struct HomeCourseCard: View {
    
    let data: CourseInfoResponse
    
    init(data: CourseInfoResponse) {
        self.data = data
    }
    
    var body: some View {
        VStack(spacing: 9, content: {
            ZStack(alignment: .topLeading, content: {
                courseImage

                Text(data.courseType.rawValue)
                    .frame(width: 43, height: 16)
                    .font(.courseTag)
                    .foregroundStyle(Color.g7)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.g2)
                    }
                    .padding(.top, 9)
                    .padding(.leading, 9)
            })
            
            courseInfo
        })
        .frame(minWidth: 311, maxHeight: 208)
        .padding(.top, 8)
        .padding(.horizontal, 7)
        .padding(.bottom, 7)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .s1w()
        }
    }
    
    // MARK: - CourseInfo
    private var courseInfo: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text(data.courseName)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.body1)
                .foregroundStyle(Color.g7)
            
            Text(data.courseDescription)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .font(.body3)
                .foregroundStyle(Color.g4)
                .lineLimit(2)
                .lineSpacing(3)
        })
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
    }
    
    @ViewBuilder
    private var courseImage: some View {
        if let url = URL(string: data.courseImage) {
            KFImage(url)
                .placeholder {
                    ProgressView()
                        .controlSize(.regular)
                }.retry(maxCount: 2, interval: .seconds(2))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: 132)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

struct CourseCard_Preview: PreviewProvider {
    static var previews: some View {
        HomeCourseCard(data: .init(courseId: 223, courseName: "경복궁", courseDescription: "ㅁㄴㅇㅁㅇㄴㅇㅁㄴㅁㄴㅇㅁㄴㅇㅇㅁㅇㅁㅇd", courseImage: "https://i.namu.wiki/i/5oX24wIySIGKLQK-xivKI_-DGXsfLmGLupQcvGVOC-luX4GkZZBZJf3OYC96jlGHFGdqzaNpoRULIPjYsSmI8k-OTB1J-v1ZHxU8ILUO8zMI2AH2nGBqIACorKDlDHFywU58LEvaYrR6Hyq043vBeQ.webp", courseType: .ai))
    }
}
