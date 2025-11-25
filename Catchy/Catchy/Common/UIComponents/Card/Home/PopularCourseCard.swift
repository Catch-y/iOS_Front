//
//  PopularCourseCard.swift
//  Catchy
//
//  Created by Apple Coding machine on 11/25/25.
//

import SwiftUI

struct PopularCourseCard: View, Equatable {
    
    // MARK: - Property
    let data: CourseBestResponse
    
    // MARK: - Constant
    fileprivate enum PopularCourseConstants {
        static let bottomPadding: CGFloat = 30
        static let lineSpacing: CGFloat = 2.5
        
        static let title: CGFloat = 50
        static let cardHeight: CGFloat = 260
        
        static let lineLimit: Int = 2
        static let offSetX: CGFloat = 20
        static let offSetY: CGFloat = 35
        static let cornerRadius: CGFloat = 20
    }
    
    // MARK: - Equatable
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.data.courseImage == rhs.data.courseImage
    }
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomLeading, content: {
            image
            imageInfo
        })
    }
    
    // MARK: - TopArea
    private var image: some View {
        RemoteImage(
            urlString: data.courseImage,
            size: .init(width: getScreenSize().width, height: PopularCourseConstants.cardHeight),
            cornerRadius: PopularCourseConstants.cornerRadius
        )
        .overlay {
            LinearGradient(
                stops: [
                    Gradient.Stop(color: .black.opacity(0.6), location: 0.00),
                    Gradient.Stop(color: .black.opacity(0.5), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
            )
        }
    }
    
    /// 이미지 타이틀
    private var imageInfo: some View {
        Text(data.courseName)
            .frame(maxWidth: .infinity)
            .frame(height: PopularCourseConstants.title, alignment: .leading)
            .font(.Subtitle3)
            .lineModifier(lineLimit: PopularCourseConstants.lineLimit, lineSpacing: PopularCourseConstants.lineSpacing)
            .foregroundStyle(.white)
            .safeAreaPadding(.bottom, PopularCourseConstants.bottomPadding)
    }
}

#Preview {
    PopularCourseCard(data: .init(courseId: 0, courseImage: "https://i.namu.wiki/i/oDvEwMBTkSYTT4gLw2EszMRn1CHDCa0dvnGAKFN6ViFJ4zhn4JV76LyXliZli5EzaO6lPpt8M61iWZuN38US-_D7mLMZNYjnj-QLuCLaYFM-Xd4pVSTDtJIdZsFxK68BXpPQ36akNvSlubrsheoLHg.webp", courseName: "커플들 위한 크리스마스 데이트 코스"))
}
