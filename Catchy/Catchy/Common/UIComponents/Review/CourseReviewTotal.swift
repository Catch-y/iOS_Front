//
//  CourseReviewTotal.swift
//  Catchy
//
//  Created by euijjang97 on 1/8/26.
//

import SwiftUI

struct CourseReviewTotal: View, Equatable {
    
    let totalInfo: ReviewTotalInfo
    
    init(totalInfo: ReviewTotalInfo) {
        self.totalInfo = totalInfo
    }
    
    private enum Constants {
        static let mainVspacing: CGFloat = 11
        static let visitReviewSpacing: CGFloat = 13
        static let reviewRatingSpacing: CGFloat = 4
        static let starSize: CGSize = .init(width: 18, height: 18)
        static let mainPadding: CGFloat = 20
        
        static let visitTitle: String = "방문자 리뷰"
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.totalInfo == rhs.totalInfo
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.mainVspacing, content: {
            reviewTotal
            reviewCount
        })
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Constants.mainPadding)
        .background {
            RoundedRectangle(cornerRadius: DefaultConstants.defaultCornerRadius)
                .fill(.clear)
                .strokeBorder(.g3, style: .init())
        }
    }
    
    /// 방문자 리뷰
    private var reviewTotal: some View {
        HStack(spacing: Constants.visitReviewSpacing, content: {
            Text(Constants.visitTitle)
                .font(.body1)
                .foregroundStyle(.g7)
            
            Text("\(totalInfo.totalCount)")
                .font(.body1)
                .foregroundStyle(.main)
        })
    }
    
    private var reviewCount: some View {
        HStack {
            ReviewStars(
                rating: .constant(
                    Int(
                        totalInfo.averageRating.rounded()
                    )
                ),
                size: Constants.starSize
            )
            
            reviewRatingPoint
        }
    }
    
    private var reviewRatingPoint: some View {
        HStack(spacing: Constants.reviewRatingSpacing, content: {
            Text("\(Int(totalInfo.averageRating.rounded()))")
                .foregroundStyle(.g7)
            
            Group {
                Text("/")
                Text("5")
            }
            .foregroundStyle(.g4)
        })
        .font(.body1)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CourseReviewTotal(totalInfo: .init(totalCount: 523, averageRating: 3.5, ratingInfo: nil))
}
