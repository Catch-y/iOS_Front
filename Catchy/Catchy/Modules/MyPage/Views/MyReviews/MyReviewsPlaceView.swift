//
//  MyReviewsPlaceView.swift
//  Catchy
//
//  Created by 권용빈 on 2/14/25.
//

import SwiftUI

/// 사용자가 작성한 장소 리뷰 목록을 보여주는 화면
struct MyPlaceReviewsView: View {
    
    @StateObject var viewModel: MyPlaceReviewsViewModel
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 22, content: {
            if !viewModel.isLoading {
                if let data = viewModel.myPlaceReviewsData {
                    contentSection(data: data)
                        .padding(.horizontal, 16)
                } else {
                    CustomEmptyStateView(label: "작성하신 장소 리뷰가 없습니다.", subLabel: "내가 방문한 장소에 대한 리뷰를 적어주세요!")
                        .padding(.top, 231)
                    Spacer()
                }
            } else {
                MainProgressComponents()
            }
        })
        .onAppear {
            viewModel.getMyPlaceReviews(review: .init(pageSize: 10, lastPlaceReviewDate: "1", lastReviewId: 1))
        }
    }
    
    // MARK: - 리뷰 콘텐츠
    private func contentSection(data: MyPlaceReviewResponse) -> some View {
        VStack(alignment: .leading, spacing: 22, content: {
            reviewCountSection(count: data.reviewCount)
            reviewTableSection(content: data.content)
        })
    }
    
    private func reviewCountSection(count: Int) -> some View {
        HStack(spacing: 9, content: {
            Text("작성한 리뷰")
                .font(.body2)
                .foregroundStyle(Color.g6)
            Text("\(count)")
                .font(.body2)
                .foregroundStyle(Color.m6)
        })
    }
    
    private func reviewTableSection(content: [PlaceReviewData]) -> some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(content, id: \ .reviewId) { review in
                    ReviewCard(
                        cardType: .myReview,
                        reviewType: .place,
                        reviewId: review.reviewId,
                        comment: review.comment,
                        images: review.reviewImages,
                        categories: review.categories,
                        rating: review.rating,
                        placeOrCourseName: review.name,
                        userName: nil,
                        date: review.visitedDate
                    )
                    .padding(.bottom, 40)
                    if review.reviewId != content.last?.reviewId {
                        Divider()
                            .background(Color.g3)
                            .padding(.bottom, 40)
                    }
                }
            }
        }
    }
}

struct MyPlaceReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro", "iPhone 11"], id: \ .self) { deviceName in
            MyPlaceReviewsView(container: DIContainer())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
