//
//  ReviewView.swift
//  Catchy
//
//  Created by 권용빈 on 1/20/25.
//

import SwiftUI
import Kingfisher

struct PlaceReviewView: View {

    @EnvironmentObject var container: DIContainer
    
    @StateObject var viewModel: PlaceReviewViewModel
    
    // MARK: - 장소 리뷰, 평점 화면 Propertes
    /// 현재 장소 ID
    let placeId: Int
    
    // MARK: - Init
    init(container: DIContainer, placeId: Int) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
        self.placeId = placeId
    }
    
    // MARK: - Body
    var body: some View {
        
        VStack(alignment: .center, spacing: 20, content: {
                CustomNavigation(action: {
                    container.navigationRouter.pop()
                }, title: "평점, 리뷰 보기", rightNaviIcon: nil, isShadow: true)
                        
                if !viewModel.isLoading {
                    if !viewModel.placeReviewData.isEmpty {
                        ScrollView(.vertical, content: {
                            topReviewInfo()
                                .padding(.horizontal, 16)
                            reviewTableSection()
                                .padding(.horizontal, 16)
                        })
                    } else {
                        Spacer()

                        infoView()
                            .padding(.bottom, 70)
                        
                        Spacer()

                    }
                } else {
                    MainProgressComponents()
                        .padding(.bottom, 70)
                        .frame(maxWidth: .infinity)
                }
            })
        .ignoresSafeArea(.all)
        .task {
            viewModel.getPlaceReviewData(placeId: placeId)
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
        VStack(spacing: 27, content: {
            reviewTotalCount(totalCount: viewModel.totalCount)
            
            HStack(alignment: .center, content: {
                
                reviewTotalStar(totalRating: viewModel.averageRating)
                
                Spacer()
                /* 세로선 */
                Rectangle()
                    .fill(.g3)
                    .frame(width: 1, height: 60)
                
                Spacer()
                
                reviewGraphSection(reviewCount: viewModel.ratingList, totalPersonCount: viewModel.totalCount)
                
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
    private func reviewTableSection() -> some View {
        VStack(alignment: .center, spacing: 8, content: {
            ForEach(viewModel.placeReviewData, id: \.id) { review in
                ReviewCard(
                    cardType: .ratingReview,
                    reviewType: .place,
                    reviewId: review.reviewId,
                    comment: review.comment,
                    images: review.reviewImages,
                    action: {reviewId in print("\(reviewId) 신고하기")},
                    categories: nil,
                    rating: review.rating,
                    placeOrCourseName: nil,
                    userName: review.creatorNickname,
                    date: review.visitedDate
                    )
                .padding(.vertical, 26)
                .task {
                    if viewModel.placeReviewData.last?.reviewId == review.reviewId {
                        viewModel.getPlaceReviewData(placeId: placeId)
                    }
                }
                if review.reviewId != viewModel.placeReviewData.last?.reviewId {
                    Divider()
                        .background(Color.g3)
                }
            }
        })
    }
}


struct ReviewView_Preview: PreviewProvider {
    
    static var devices = ["iPhone 11", "iPhone 16 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            PlaceReviewView(container: DIContainer(), placeId: 1)
                .environmentObject(DIContainer())
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
