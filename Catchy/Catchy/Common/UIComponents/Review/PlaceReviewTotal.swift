//
//  PlaceReviewTotal.swift
//  Catchy
//
//  Created by euijjang97 on 12/22/25.
//

import SwiftUI

struct PlaceReviewTotal: View, Equatable {
    
    // MARK: - Property
    let totalInfo: ReviewTotalInfo
    
    // MARK: - Init
    init(totalInfo: ReviewTotalInfo) {
        self.totalInfo = totalInfo
    }
    
    private enum Constants {
        static let mainVspacing: CGFloat = 27
        static let totalPadding: EdgeInsets = .init(top: 15, leading: 22, bottom: 31, trailing: 22)
        static let mainHeight: CGFloat = 160
    }
    
    // MARK: - Equtable
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.totalInfo == rhs.totalInfo
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.mainVspacing, content: {
            VisitCountView(count: totalInfo.totalCount)
            
            HStack {
                AverageRatingSummary(rating: totalInfo.averageRating)
                
                Spacer()
                
                Divider()
                    .rotationEffect(.degrees(1/2))
                    .foregroundStyle(.g3)
                
                Spacer()
                
                if let ratingInfo = totalInfo.ratingInfo {
                    PointProgress(ratingInfo: ratingInfo)
                }
            }
        })
        .frame(height: Constants.mainHeight)
        .padding(Constants.totalPadding)
        .background {
            RoundedRectangle(cornerRadius: DefaultConstants.defaultCornerRadius)
                .fill(.clear)
                .strokeBorder(.g3, style: .init())
        }
    }
}

// MARK: - VisitCountInfo
fileprivate struct VisitCountView: View, Equatable {
    let count: Int
    
    var body: some View {
        HStack {
            Text("방문자 리뷰")
                .font(.body1)
                .foregroundStyle(.g7)
            
            Spacer()
            
            Text("\(count)개")
                .font(.body1)
                .foregroundStyle(.main)
        }
    }
}

// MARK: - AverageRatingSummary
fileprivate struct AverageRatingSummary: View, Equatable {
    let rating: Double
    
    private enum Constants {
        static let averagePointSpacing: CGFloat = 6
        static let averageVspacing: CGFloat = 2
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.averageVspacing, content: {
            scoreText
            
            ReviewStars(rating: .constant(Int(rating.rounded())))
                .disabled(true)
        })
    }
    
    private var scoreText: some View {
        HStack(spacing: Constants.averagePointSpacing) {
            Text(String(format: "%.0f", rating))
                .font(.headline1)
                .foregroundStyle(.black)
            
            HStack(spacing: .zero) {
                Text("/")
                Text("5")
            }
            .font(.subtitle1)
            .foregroundStyle(.g4)
        }
    }
}

// MARK: - PointProgress
fileprivate struct PointProgress: View, Equatable {
    
    let ratingInfo: [PlaceAllReviewResponse.Rating]
    
    var maxCount: Double {
        Double(ratingInfo.map { $0.count }.max() ?? 1)
    }
    
    private enum Constant {
        static let mainVspacing: CGFloat = 12
    }
    
    var body: some View {
        VStack(spacing: Constant.mainVspacing, content: {
            ForEach(ratingInfo, id: \.id) { info in
                RatingRow(rating: info, totalCount: maxCount)
            }
        })
    }
}

// MARK: - RatingRowBar
fileprivate struct RatingRow: View {
    let rating: PlaceAllReviewResponse.Rating
    let totalCount: Double
    
    var ratio: Double {
        guard totalCount > 0 else { return 0 }
        return Double(rating.count) / totalCount
    }
    
    private enum Constant {
        static let mainHspacing: CGFloat = 10
        static let progressHeight: CGFloat = 8
    }
    
    var body: some View {
        HStack(spacing: Constant.mainHspacing, content: {
            Text("\(rating.score)점")
                .font(.caption2)
                .foregroundStyle(.g5)
            
            progressBar
            
            Text(ratingCount)
                .font(.caption2)
                .foregroundStyle(.g4)
        })
    }
    
    private var progressBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.g2)
                
                Capsule()
                    .fill(.m5)
                    .frame(width: geometry.size.width * ratio)
            }
        }
        .frame(height: Constant.progressHeight)
    }
    
    private var ratingCount: String {
        if rating.count > 999 {
            return "999+"
        } else {
            return "\(rating.count)명"
        }
    }
}

#Preview {
    PlaceReviewTotal(totalInfo: .init(totalCount: 44, averageRating: 4.7, ratingInfo: [
        .init(score: 5, count: 50),
        .init(score: 4, count: 40),
        .init(score: 3, count: 30),
        .init(score: 2, count: 20),
        .init(score: 1, count: 1),
    ]))
}
