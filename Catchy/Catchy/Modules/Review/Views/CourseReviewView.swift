//
//  CourseReviewView.swift
//  Catchy
//
//  Created by 권용빈 on 2/17/25.
//

import SwiftUI

struct CourseReviewView: View {
    
    @StateObject var viewModel: CourseReviewViewModel
    @EnvironmentObject var container: DIContainer
    
    // MARK: - 장소 리뷰, 평점 화면 Propertes
    /// 현재 장소 ID
    let courseId: Int
    
    /// 현재 화면의 상태
    @Binding var isPresented: Bool
    
    // MARK: - Init
    init(container: DIContainer, courseId: Int, isPresented: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
        self.courseId = courseId
        self._isPresented = isPresented
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 28, content: {
                CustomNavigation(action: {
                    container.navigationRouter.pop()
                }, title: "평점, 리뷰 보기", leftNaviIcon: nil, isShadow: true)
            if !viewModel.isLoading {
                if !viewModel.courseReviewData.isEmpty {
                    ScrollView(.vertical, content: {
                        topReviewInfo()
                            .padding(.horizontal, 16)
                        reviewTableSection()
                            .padding(.top, 15)
                            .padding(.horizontal, 16)
                    })
                } else {
                    infoView()
                        .padding(.top, 107)
                }
            } else {
                MainProgressComponents()
                }
            })
        .ignoresSafeArea(.all)
        .task {
            viewModel.getCourseReviewData(courseId: self.courseId)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - 리뷰 없을 때, 보일 가이드 뷰
    
    private func infoView() -> some View {
        VStack(spacing: 9) {
            
            Text("작성된 리뷰가 없습니다.")
                .font(.Subtitle2)
                .foregroundColor(.g7)
            
            Text("새로운 리뷰가 작성될 때까지 기다려보세요!")
                .font(.Body1_2)
                .foregroundColor(.g4)
        }
    }
    // MARK: - 상단 평점 및 리뷰 전체 정보
    
    /// 상단 리뷰 평점 정보
    /// - Parameter data: 리뷰 데이터를 담고 있는 ReviewResponse
    /// - Returns: 리뷰 평점과 총 리뷰 개수를 보여주는 상단 뷰
    private func topReviewInfo() -> some View {
        VStack(alignment: .leading, spacing: 11, content: {
            reviewTotalCount(totalCount: viewModel.totalCount)
            reviewTotalRating(averageRating: viewModel.courseRating)
        })
        
        .padding(.top, 19)
        .padding(.bottom, 19)
        .padding(.leading, 20)
        .padding(.trailing, 176)
        .frame(maxWidth: .infinity)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 15)
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
                .foregroundStyle(Color.g7)
            Text("\(totalCount)개")
                .font(.body1)
                .foregroundColor(.main)
        })
    }
    
    
    /// 총 평점을 표시하는 뷰
    /// - Parameter totalRating: 평균 평점 값 (소수점 한 자리까지)
    /// - Returns: 평균 평점과 별점 표시, 별점 그래프 포함
    private func reviewTotalRating(averageRating: Double) -> some View {
        return HStack(alignment: .center, spacing: 8, content: {
            StarRating(rating: averageRating)
            
            Text(String(format: "%.1f", averageRating))
                .font(.body1)
                .foregroundStyle(Color.g7)
            
            Group {
                Text("/")
                
                Text("5")
            }
            .font(.body1)
            .foregroundStyle(Color.g4)
        })
    }
    
    // MARK: - 하단 리뷰 테이블 섹션
    
    /// 하단 리뷰 테이블 섹션
    /// - Parameter content: 리뷰 데이터 배열
    /// - Returns: 리뷰 목록과 구분선을 포함하는 뷰
    private func reviewTableSection() -> some View {
        VStack(alignment: .center, spacing: 8, content: {
            ForEach(viewModel.courseReviewData, id: \.id) { review in
                ReviewCard(
                    cardType: .ratingReview,
                    reviewType: .course,
                    reviewId: review.reviewId,
                    comment: review.comment,
                    images: review.reviewImages,
                    //TODO: - 신고하기 액션 추가
                    action: {reviewId in print("\(reviewId)신고하기")},
                    categories: nil,
                    rating: nil,
                    placeOrCourseName: nil,
                    userName: review.creatorNickname,
                    date: review.createdAt
                    )
                .padding(.vertical, 30)
                .task {
                    if viewModel.courseReviewData.last?.reviewId == review.reviewId {
                        viewModel.getCourseReviewData(courseId: courseId)
                    }
                }
                
                if review.reviewId != viewModel.courseReviewData.last?.reviewId {
                    Divider()
                        .background(Color.g3)
                }
            }
        })
    }
}


struct CourseReviewView_Preview: PreviewProvider {
    
    static var devices = ["iPhone 11", "iPhone 16 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            CourseReviewView(container: DIContainer(), courseId: 1, isPresented: .constant(true))
                .environmentObject(DIContainer())
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
