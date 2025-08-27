//
//  MyReviewsCourse.swift
//  Catchy
//
//  Created by 권용빈 on 2/14/25.
//

import SwiftUI

/// 사용자가 작성한 코스 리뷰 목록을 보여주는 화면
struct MyCourseReviewsView: View {
    
    @ObservedObject var viewModel: MyCourseReviewsViewModel
    @EnvironmentObject var parentViewModel: MyReviewsViewModel
    
    init(viewModel: MyCourseReviewsViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 22, content: {
            if viewModel.isMyCourseReviewsLoading {
                MainProgressComponents()
                    .frame(maxWidth: .infinity)
            } else {
                if viewModel.myCourseReviews.isEmpty {
                    VStack(content: {
                        HStack(content: {
                            reviewCountSection(count: 0)
                            
                            Spacer()
                        })
                        
                        CustomEmptyStateView(label: "작성하신 코스 리뷰가 없습니다.", subLabel: "내가 방문한 코스에 대한 리뷰를 적어주세요!")
                            .padding(.top, 231)
                        
                    })
                    Spacer()
                    
                } else {
                    contentSection(data: viewModel.myCourseReviews)
                }
                
            }
        })
        .task {
            viewModel.getMyCourseReviews()
        }
    }

    // MARK: - 리뷰 콘텐츠
    
    ///  리뷰 콘텐츠 섹션
    /// - Parameter data: 내 코스 리뷰 response Data
    /// - Returns: 코스 리뷰 콘텐츠 뷰
    private func contentSection(data: [CourseReviewData]) -> some View {
        VStack(alignment: .leading, spacing: 22) {
            reviewCountSection(count: viewModel.reviewCount)
            reviewTableSection(content: data)
        }
    }
    
    /// 리뷰 수 섹션
    /// - Parameter count: 리뷰 개수
    /// - Returns: 리뷰 개수 뷰
    private func reviewCountSection(count: Int) -> some View {
        HStack(spacing: 9) {
            Text("작성한 리뷰")
                .font(.body2)
                .foregroundStyle(Color.g6)
            Text("\(count)개")
                .font(.body2)
                .foregroundStyle(Color.m6)
        }
        .padding(.horizontal, 16)
    }
    
    /// 코스 리뷰 테이블 섹션
    /// - Parameter content: 내 코스 리뷰 Response data
    /// - Returns: 내 코스 리뷰 테이블 뷰
    private func reviewTableSection(content: [CourseReviewData]) -> some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(content, id: \.id) { review in
                    ReviewCard(
                        cardType: .myReview,
                        reviewType: .course,
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
                        date: review.createdDate
                    )
                    .padding(.bottom, 40)
                    .task {
                        if content.last?.reviewId == review.reviewId {
                            viewModel.getMyCourseReviews()
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

struct MyCourseReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro", "iPhone 11"], id: \ .self) { deviceName in
            MyCourseReviewsView(viewModel: .init(container: DIContainer()))
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
                .environmentObject(MyReviewsViewModel(container: DIContainer()))
        }
    }
}
