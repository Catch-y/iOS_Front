//
//  CourseReviewView.swift
//  Catchy
//
//  Created by 권용빈 on 2/17/25.
//

import SwiftUI

struct CourseReviewView: View {
    
    @StateObject var viewModel: CourseReviewViewModel
    
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
        
        
        VStack(alignment: .center, spacing: 20, content: {
            if !viewModel.isLoading {
                CustomNavigation(action: {
                    isPresented.toggle()
                }, title: "평점, 리뷰 보기", leftNaviIcon: nil, isShadow: true)
                
                if let data = viewModel.courseReviewData {
                    ScrollView(.vertical, content: {
                        topReviewInfo(data: data)
                        
                        if !data.content.isEmpty {
                            reviewTableSection(content: data.content)
                                .padding(.top, 7)
                        } else {
                            infoView()
                                .padding(.top, 107)
                        }
                    })
                    .padding(.horizontal, 16)
                } else {
                    MainProgressComponents()
                }
            } else {
                MainProgressComponents()
            }
        })
        .ignoresSafeArea(.all)
        .task {
            
        }
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
    private func topReviewInfo(data: CourseReviewInfoResponse) -> some View {
        VStack(spacing: 11, content: {
            reviewTotalCount(totalCount: data.totalCount)
            reviewTotalRating(averageRating: data.courseRating)
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
        return HStack(spacing: 8,content: {
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
    private func reviewTableSection(content: [CourseReviewContents]) -> some View {
        VStack(alignment: .center, spacing: 8, content: {
            ForEach(content, id: \.reviewId) { review in
                ReviewCard(
                    cardType: .ratingReview,
                    reviewType: .place,
                    reviewId: review.reviewId,
                    comment: review.comment,
                    images: review.reviewImages,
                    categories: nil,
                    rating: nil,
                    placeOrCourseName: nil,
                    userName: review.creatorNickname,
                    date: review.createdAt
                    )
                Divider()
                    .background(.g3)
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
