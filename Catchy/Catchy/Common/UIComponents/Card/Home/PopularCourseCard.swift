//
//  PopularCourseCard.swift
//  Catchy
//
//  Created by Apple Coding machine on 11/25/25.
//

import SwiftUI

struct PopularCourseCard: View, Equatable {
    
    // MARK: - Property
    @Namespace var namespace
    let data: CourseBestResponse
    let rank: Int
    
    // MARK: - Constant
    fileprivate enum PopularCourseConstants {
        static let bottomPadding: CGFloat = 30
        static let lineSpacing: CGFloat = 2.5
        static let bigNumberPadding: EdgeInsets = .init(top: -20, leading: 0, bottom: -10, trailing: 10)
        
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
        GeometryReader { geo in
            let minX = geo.frame(in: .scrollView).minX
            let width = geo.size.width
            let height = geo.size.height
            
            ZStack(alignment: .bottomLeading, content: {
                parallaxImageLayer(size: .init(width: width, height: height), minX: minX)
                gradientOverlay
                bigRankNumber
                contentLayer
            })
            .clipShape(RoundedRectangle(cornerRadius: DefaultConstants.defaultCornerRadius))
            .padding(.horizontal, DefaultConstants.defaultSafeHorizon)
            .glassEffectTransition(.matchedGeometry)
            .glassEffectID("card", in: namespace)
        }
    }
    
    // MARK: - TopArea
    /// 이미지 레이어 표시
    /// - Parameters:
    ///   - size: 이미지 사이즈
    ///   - minX: 이미지 MinX
    /// - Returns: 이미지 뷰 반환
    private func parallaxImageLayer(size: CGSize, minX: CGFloat) -> some View {
        RemoteImage(
            urlString: data.courseImage,
            size: .init(width: size.width * 1.4, height: size.height),
            cornerRadius: PopularCourseConstants.cornerRadius
        )
        .offset(x: -minX * 0.5)
    }
    
    /// 이미지 위 그라디언트 레이어
    private var gradientOverlay: some View {
        LinearGradient(
            stops: [
                .init(color: .clear, location: 0.3),
                .init(color: .black.opacity(0.8), location: 1.0)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    /// 순위 글자 표시
    private var bigRankNumber: some View {
        Text("\(rank)")
            .font(.system(size: 110, weight: .black, design: .rounded))
            .foregroundStyle(.m1.opacity(0.6))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(PopularCourseConstants.bigNumberPadding)
    }
    
    /// 이미지 위 컨텐츠 레이어
    private var contentLayer: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            HStack(spacing: 4) {
                Text("TOP")
                    .font(.body2)
                Text("\(rank)")
                    .font(.body3)
            }
            .foregroundStyle(.black)
            .bold()
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(Color.white, in: Capsule())
            
            // 코스 제목
            Text(data.courseName)
                .font(.Subtitle3)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        })
        .padding(20)
    }
}

#Preview {
    PopularCourseCard(data: .init(courseId: 0, courseImage: "https://picsum.photos/600/800", courseName: "커플들 위한 크리스마스 데이터 코스"), rank: 1)
}
