//
//  CosCard.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import SwiftUI
import Kingfisher

struct CourseCard: View {
    
    let data: CourseInfoResponse
    
    init(data: CourseInfoResponse) {
        self.data = data
    }
    
    var body: some View {
        VStack(spacing: 9, content: {
            courseImage
            
            courseInfo
        })
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
            HStack(spacing: 10, content: {
                Text(data.courseName)
                    .font(.body1)
                    .foregroundStyle(Color.g7)
                    .padding(.leading, 2)
                
                Text(data.courseType.rawValue)
                    .frame(width: 43, height: 16)
                    .font(.courseTag)
                    .foregroundStyle(Color.g7)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.g2)
                    }
            })
            
            Text(data.courseDescription)
                .frame(width: 284, alignment: .top)
                .font(.body3)
                .foregroundStyle(Color.g4)
                .lineLimit(2)
                .lineSpacing(3)
        })
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
                .frame(width: 311, height: 132)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

struct CourseCard_Preview: PreviewProvider {
    static var previews: some View {
        CourseCard(data: CourseInfoResponse(courseId: UUID(), id: 1, courseType: .diy, courseImage: "https://i.namu.wiki/i/tFLNGekMqpK-fhVmb0NZk-9eBwj5Z6bN5LSGdOqV6t96kfz135jcbZrOuLb_76rMFLMxCy0EgTjeMauhP5SWPSCQXWD7bFRUJBGSDscQaXKyT20t3Mp3buFiW_92UEu99f58pBnGrAtrSaOaHE9JGw.webp", courseName: "코스 이름 아홉자 정도", courseDescription: "코스에 대한 설명 어쩌구 저쩌구 텍스트 길이 테스트 해볼게요 두줄 정렬 하게 되면 이 정도 간격으로 그리고 최대 길이", categories: [.cafe, .bar]))
            .previewLayout(.sizeThatFits)
    }
}
