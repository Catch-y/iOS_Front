//
//  RatingReviewView.swift
//  Catchy
//
//  Created by 권용빈 on 1/20/25.
//

import SwiftUI
import Kingfisher

struct ReviewView: View {
    
    @StateObject var viewModel: ReviewsViewModel
    
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    // MARK: - Body
    var body: some View {
        
        if let data = viewModel.reviewData {
            VStack(alignment: .center, spacing: 20, content: {
                
                CustomNavigation(action: {
                    print("hello")
                }, title: "평점, 리뷰 보기", leftNaviIcon: nil)
                .s1w()
                
                ScrollView(.vertical, content: {
                    topReviewInfo(data: data)
                    
                    reviewTableSection(content: data.content)
                        .padding(.top, 7)
                })
                .frame(maxWidth: .infinity)
                
            })
            .safeAreaPadding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        } else {
            VStack(alignment: .center, content: {
                Spacer()
                
                ProgressView()
                    .controlSize(.regular)
                
                Spacer()
            })
            .task {
                viewModel.getReviewData(reviewData: GetReviewRequest(placeId: 12345, page: 2))
            }
        }
    }
    
    // MARK: - 상단 평점 및 리뷰 전체 정보
    
    /// 상단 리뷰 평점 정보
    /// - Parameter data: 리뷰 데이터를 담고 있는 ReviewResponse
    /// - Returns: 리뷰 평점과 총 리뷰 개수를 보여주는 상단 뷰
    private func topReviewInfo(data: ReviewResponse) -> some View {
        VStack(spacing: 27, content: {
            reviewTotalCount(totalCount: data.totalCount)
            
            HStack(alignment: .center, content: {
                
                reviewTotalStar(totalRating: data.totalRating)
                
                Spacer()
                /* 세로선 */
                Rectangle()
                    .fill(.g3)
                    .frame(width: 1, height: 60)
                
                Spacer()
                
                reviewGraphSection(reviewCount: data.reviewCount, totalPersonCount: data.totalCount)
                
            })
            .frame(height: 74)
        })

        .padding(.top, 16)
        .padding(.bottom, 32)
        .padding(.leading, 29)
        .padding(.trailing, 16)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.clear)
                .stroke(Color.g3, lineWidth: 1)
        })
        
    }
    
    
    /// 리뷰 총 개수 표시 뷰
    /// - Parameter totalCount: 총 리뷰 개수
    /// - Returns: 방문자 리뷰와 리뷰 개수를 표시하는 뷰
    private func reviewTotalCount(totalCount: Int) -> some View {
        return HStack(alignment: .center, spacing: 13, content: {
            Text("방문자 리뷰")
                .font(.body1)
                .foregroundColor(.black)
            Text("\(totalCount)개")
                .font(.body1)
                .foregroundColor(.main)
        })
    }
    
    
    /// 총 평점을 표시하는 뷰
    /// - Parameter totalRating: 평균 평점 값 (소수점 한 자리까지)
    /// - Returns: 평균 평점과 별점 표시, 별점 그래프 포함
    private func reviewTotalStar(totalRating: Double) -> some View {
        return VStack(alignment: .center, spacing: 2,content: {
            HStack(spacing: 9, content: {
                Text(String(format: "%.1f", totalRating))
                    .font(.Headline1)
                    .foregroundColor(.g7)
                
                Group {
                    Text("/")
                    
                    Text("5")
                }
                .font(.Subtitle1)
                .foregroundColor(.g4)
            })
            .frame(width: 122)
            
            StarRating(rating: totalRating)
        })
    }
    
    
    /// 별점 분포 그래프
    /// - Parameters:
    ///   - reviewCount: 각 별점에 해당하는 리뷰 개수
    ///   - totalPersonCount: 총 리뷰 개수
    /// - Returns: 별점 분포를 나타내는 막대그래프 뷰
    private func reviewGraphSection(reviewCount: [ScoreCount], totalPersonCount: Int) -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 0, maximum: 140)), count: 1), spacing: 6,  content: {
            ForEach(reviewCount.reversed(), id: \.score) { scoreData in
                ReviewGraph(
                    score: scoreData.score,
                    personCount: scoreData.count,
                    totalPersonCount: totalPersonCount
                )
            }
        })
        .frame(width: 140)
    }
    
    // MARK: - 하단 리뷰 테이블 섹션
    
    /// 하단 리뷰 테이블 섹션
    /// - Parameter content: 리뷰 데이터 배열
    /// - Returns: 리뷰 목록과 구분선을 포함하는 뷰
    private func reviewTableSection(content: [ReviewContents]) -> some View {
        VStack(alignment: .center, spacing: 8, content: {
            ForEach(content, id: \.reviewId) { review in
                ReviewCard(data: review)
                Divider()
                    .background(.g3)
            }
        })
    }
}

//
//struct ReviewView_Preview: PreviewProvider {
//    
//    static var devices = ["iPhone 11", "iPhone 16 Pro"]
//    
//    static var previews: some View {
//        ForEach(devices, id: \.self) { device in
//            ReviewView(container: DIContainer())
//                .environmentObject(DIContainer())
//                .previewDevice(PreviewDevice(rawValue: device))
//                .previewDisplayName(device)
//        }
//    }
//}

#Preview {
    ReviewView(container: DIContainer())
}
