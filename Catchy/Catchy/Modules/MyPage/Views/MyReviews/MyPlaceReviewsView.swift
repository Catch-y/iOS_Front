//
//  MyReviewsPlaceView.swift
//  Catchy
//
//  Created by 권용빈 on 2/14/25.
//

import SwiftUI

/// 사용자가 작성한 장소 리뷰 목록을 보여주는 화면
struct MyPlaceReviewsView: View {
    
    @ObservedObject var viewModel: MyPlaceReviewsViewModel
    @EnvironmentObject var parentViewModel: MyReviewsViewModel
    
    init(viewModel: MyPlaceReviewsViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 22, content: {
            if viewModel.isMyPlaceReviewsLoading {
                MainProgressComponents()
            } else {
                if viewModel.myPlaceReviews.isEmpty {
                    VStack(content: {
                        HStack(content: {
                            reviewCountSection(count: 0)
                            
                            Spacer()
                        })
                        
                        CustomEmptyStateView(label: "작성하신 장소 리뷰가 없습니다.", subLabel: "내가 방문한 장소에 대한 리뷰를 적어주세요!")
                            .padding(.top, 231)
                        
                    })
                    Spacer()
                } else {
                    contentSection(data: viewModel.myPlaceReviews)
                }
            }
        })
        .task {
            viewModel.getMyPlaceReviews()
        }
    }
    
    // MARK: - 리뷰 콘텐츠
    private func contentSection(data: [PlaceReviewData]) -> some View {
        VStack(alignment: .leading, spacing: 22, content: {
            reviewCountSection(count: viewModel.reviewCount)
            reviewTableSection(content: data)
        })
    }
    
    private func reviewCountSection(count: Int) -> some View {
        HStack(spacing: 9, content: {
            Text("작성한 리뷰")
                .font(.body2)
                .foregroundStyle(Color.g6)
            Text("\(count)개")
                .font(.body2)
                .foregroundStyle(Color.m6)
        })
        .padding(.horizontal, 16)
    }
    
    private func reviewTableSection(content: [PlaceReviewData]) -> some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(content, id: \.id) { review in
                    ReviewCard(
                        cardType: .myReview,
                        reviewType: .place,
                        reviewId: review.reviewId,
                        comment: review.comment,
                        images: review.reviewImages,
                        action: { reviewId in
                            parentViewModel.openDeletePopup(reviewId: reviewId)
                        },
                        categories: review.categories,
                        rating: review.rating,
                        placeOrCourseName: review.name,
                        userName: nil,
                        date: review.visitedDate
                    )
                    .padding(.bottom, 40)
                    .task {
                        if content.last?.reviewId == review.reviewId {
                            viewModel.getMyPlaceReviews()
                        }
                    }

                    if review.reviewId != content.last?.reviewId {
                        Divider()
                            .background(Color.g3)
                            .padding(.bottom, 40)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct MyPlaceReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro", "iPhone 11"], id: \ .self) { deviceName in
            MyPlaceReviewsView(viewModel: .init(container: DIContainer()))
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
