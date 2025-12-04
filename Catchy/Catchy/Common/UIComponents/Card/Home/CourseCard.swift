//
//  CourseCard.swift
//  Catchy
//
//  Created by Apple Coding machine on 11/25/25.
//

import SwiftUI

/// 홈 첫 번째 섹션 카드
struct CourseCard: View, Equatable {
    // TODO: - 이미지 배경 수정
    /*
     카드 이미지 AI 활용
     만약, AI 리소스 없을 경우, 지정된 이미지로 보이게 수정 필요
     */
    
    // MARK: - Property
    let data: CourseRecommendResponse
    @Namespace var namespace
    
    // MARK: - Constant
    fileprivate enum CourseCardConstraint {
        static let courseInfoVspacing: CGFloat = 10
        static let courseStackPadding: CGFloat = 10
        static let courseCardVspacing: CGFloat = 18
        static let courseCardPadding: EdgeInsets = .init(top: 8, leading: 7, bottom: 7, trailing: 7)
        
        static let courseTagSize: CGSize = .init(width: 43, height: 16)
        static let courseTagOffset: CGFloat = 9
        static let courseImageHeight: CGFloat = 132
        
        static let lineLinmit: Int = 2
        static let lineSpacing: CGFloat = 3
        static let cornerRadius: CGFloat = 15
    }
    
    // MARK: - Equatable
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.data.courseImage == rhs.data.courseImage
    }
    
    // MARK: - Init
    init(data: CourseRecommendResponse) {
        self.data = data
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: CourseCardConstraint.courseCardVspacing, content: {
            topContent
            bottomContent
        })
        .padding(CourseCardConstraint.courseCardPadding)
        .background {
            RoundedRectangle(cornerRadius: CourseCardConstraint.cornerRadius)
                .fill(Color.white)
        }
        .glassEffect(.regular.interactive(), in: RoundedRectangle(cornerRadius: CourseCardConstraint.cornerRadius))
        .glassEffectID("card", in: namespace)
        .padding(.horizontal, DefaultConstants.defaultSafeHorizon)
    }
    
    // MARK: - Top
    private var topContent: some View {
        ZStack(alignment: .topLeading, content: {
            courseImage
            courseTag
        })
    }
    /// 코스 사진
    private var courseImage: some View {
        RemoteImage(urlString: data.courseImage, size: .init(width: getScreenSize().width, height: CourseCardConstraint.courseImageHeight))
    }
    
    /// 코스 태그
    private var courseTag: some View {
        Text(data.courseType.rawValue)
            .frame(width: CourseCardConstraint.courseTagSize.width, height: CourseCardConstraint.courseTagSize.height)
            .font(.courseTag)
            .background {
                RoundedRectangle(cornerRadius: CourseCardConstraint.cornerRadius)
                    .fill(.white)
            }
            .offset(x: CourseCardConstraint.courseTagOffset, y: CourseCardConstraint.courseTagOffset)
    }
    // MARK: - Bottom
    /// 코스 카드 내부 코스 정보
    private var bottomContent: some View {
        VStack(alignment: .leading, spacing: CourseCardConstraint.courseInfoVspacing, content: {
            Text(data.courseName)
                .font(.body1)
                .foregroundStyle(.g7)
            
            Text(data.courseDescription)
                .font(.body3)
                .foregroundStyle(.g4)
                .lineModifier(lineLimit: CourseCardConstraint.lineLinmit, lineSpacing: CourseCardConstraint.lineSpacing)
        })
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CourseCard(data: .init(courseId: 0, courseName: "코스 이름", courseDescription: "코스에 대한 설명 어쩌구 저쩌구 텍스트 길이 테스트 해볼게요. 두 줄 정렬하게 되면 이 정도 간격 블라블라", courseImage: "https://i.namu.wiki/i/vyQx2-xaBmrzyYUAwYYR-YYz8q-c2wdXEXOJPQVK2MQjH6vmxu2Tz9A_Q37BwrVZnxiPjgUbljgoc2EeCN492NpU_maRzr6B0vqwou5EL7vOCWtzY5IeNNMMa5dxq8FK5iTOPrewSpznLmwpUX_Xdw.webp", courseType: .ai))
}
