//
//  ReviewCard.swift
//  Catchy
//
//  Created by 권용빈 on 1/23/25.
//

import SwiftUI
import Kingfisher

struct ReviewCard: View {
    
    /* 리뷰 데이터 모델 */
    
    /// 카드 타입 (마이페이지 - 내 리뷰 or 평점, 리뷰 보기)
    let cardType: ReviewCardType
    
    /// 리뷰 타입 (코스 or 장소)
    let reviewType: ReviewType
    
    /// 리뷰 ID
    let reviewId: Int
    
    /// 리뷰 내용
    let comment: String
    
    /// 리뷰 이미지
    let images: [ReviewImageData]
    
    
    /* 필요 시 표시할 데이터 */
    
    /// 카테고리 태그
    let categories: [CategoryType]?
    
    /// 평점
    let rating: Int?
    
    /// 장소 또는 코스 이름 (마이페이지 - 내 리뷰 에서 사용)
    let placeOrCourseName: String?
    
    /// 사용자 이름 (평점, 리뷰 보기에서 사용)
    let userName: String?
    
    /// 방문일 or 리뷰작성일
    let date: String?
    
    // MARK: - body
    
    var body: some View {
        reviewTableSection()
    }
    
    // MARK: - 리뷰 테이블 카드
    
    
    /// 리뷰 테이블 섹션
    /// - Parameter content: 리뷰 내용 데이터 모델
    /// - Returns: 리뷰 카드 뷰
    private func reviewTableSection() -> some View {
        VStack(alignment: .leading, spacing: 14) {
            cardTopSection()
            
            if !images.isEmpty {
                reviewImages()
            }
            
            reviewContent()
            
            reviewFooter()
        }
    }
    
    /// 1. 리뷰 상단섹션 : 내 리뷰에서는 장소 or 코스 이름 + 별점 + 삭제 / 평점 리뷰 보기에서는 별점 + 신고하기
    /// - Returns: 리뷰 상단 뷰
    private func cardTopSection() -> some View {
        switch (cardType, reviewType) {
            
        case (.myReview, .course), (.myReview, .place):
            return AnyView(
                VStack(alignment: .leading, content: {
                    HStack(content:{
                        Text(placeOrCourseName ?? "")
                            .font(.Subtitle3)
                            .foregroundStyle(Color.g7)
                            .lineLimit(2)
                            .lineSpacing(2.5)
                            .multilineTextAlignment(.leading)
                        
                        if let categories = categories {
                            /// 카테고리 태그
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 5), content: {
                                ForEach(categories, id: \.self) { category in
                                    CategoryCard(categoryType: category)
                                }
                            })
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        
                        Button {
                            withAnimation {
                                // TODO: - 신고하기 로직
                            }
                        } label: {
                            Text("삭제")
                                .font(.caption)
                                .foregroundStyle(Color.g5)
                                .underline()
                        }
                    })
                    StarRating(rating: Double(rating ?? 0))
                })
            )
            
            
            
        case (.ratingReview, .course), (.ratingReview , .place):
            return AnyView (
                HStack(content: {
                    // 별점 표시
                    StarRating(rating: Double(rating ?? 0))
                    
                    Spacer()
                    
                    // 신고하기 버튼
                    Text("신고하기")
                        .font(.caption)
                        .foregroundColor(.g5)
                        .underline()
                })
            )
        }
    }
    
    
    /// 2. 리뷰 이미지
    /// - Returns: 리뷰 이미지 뷰
    private func reviewImages() -> some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: Array(repeating: GridItem(.fixed(85)), count: 1), spacing: 6, content: {
                ForEach(images, id: \.reviewImageId) { image in
                    if let url = URL(string: image.imageUrl) {
                        KFImage(url)
                            .placeholder {
                                ProgressView()
                                    .controlSize(.regular)
                            }.retry(maxCount: 2, interval: .seconds(2))
                            .downsampling(size: CGSize(width: UIScreen.screenWidth, height: 85))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 85, height: 85)
                            .clipShape(.rect(cornerRadius: 15))
                    }
                }
                
            })
            .padding(.trailing, 10)
        }
        .frame(height: 85)
    }
    
    /// 3. 리뷰 내용
    /// - Returns: 리뷰 내용 뷰
    private func reviewContent() -> some View {
        Text(comment.split(separator: "").joined(separator: "\u{200B}"))
            .font(.body2)
            .foregroundColor(.g7)
            .lineLimit(nil)
            .lineSpacing(2)
    }
    
    
    /// 4. 닉네임과 방문일
    /// - Returns: 닉네임과 방문일 뷰
    private func reviewFooter() -> some View {
        switch (cardType, reviewType) {
        case (.myReview, .course):
            return AnyView(
                HStack(spacing: 6, content: {
                    Text("리뷰 작성일")
                        .font(.caption)
                        .foregroundStyle(Color.g4)
                    
                    Text(date ?? "")
                        .font(.caption)
                        .foregroundStyle(Color.g5)
                })
            )
            
        case (.myReview, .place):
            return AnyView(
                HStack(spacing: 6, content: {
                    Text("방문일")
                        .font(.caption)
                        .foregroundStyle(Color.g4)
                    
                    Text(date ?? "")
                        .font(.caption)
                        .foregroundStyle(Color.g5)
                })
            )
        
        case (.ratingReview, .course):
            return AnyView(
                Text(userName ?? "")
                    .font(.caption)
                    .foregroundColor(.g5)
            )
            
        case (.ratingReview, .place):
            return AnyView(
                HStack(spacing: 6, content: {
                    Text(userName ?? "")
                        .font(.caption)
                        .foregroundColor(.g5)
                    
                    // 세로선
                    Rectangle()
                        .fill(.g5)
                        .frame(width: 1, height: 8)
                    
                    Text("방문일")
                        .font(.caption)
                        .foregroundStyle(Color.g4)
                    
                    Text(date ?? "")
                        .font(.caption)
                        .foregroundStyle(Color.g5)
                })
            )
        }
    }
}

#Preview {
    ReviewCard(
        cardType: .myReview,
        reviewType: .course,
        reviewId: 1,
        comment: "스타벅스 너무 좋았어요!",
        images: [
            ReviewImageData(reviewImageId: 101, imageUrl: "https://i.namu.wiki/i/d1A_wD4kuLHmOOFqJdVlOXVt1TWA9NfNt_HA0CS0Y_N0zayUAX8olMuv7odG2FiDLDQZIRBqbPQwBSArXfEJlQ.webp"),
            ReviewImageData(reviewImageId: 102, imageUrl: "https://i.namu.wiki/i/d1A_wD4kuLHmOOFqJdVlOXVt1TWA9NfNt_HA0CS0Y_N0zayUAX8olMuv7odG2FiDLDQZIRBqbPQwBSArXfEJlQ.webp")
        ],
        categories: [.CAFE, .BAR, .CULTURELIFE, .EXPERIENCE, .REST],
        rating: 5,
        placeOrCourseName: "스타벅스 용산점",
        userName: "빈센",
        date: "2025.01.23"
    )
}
