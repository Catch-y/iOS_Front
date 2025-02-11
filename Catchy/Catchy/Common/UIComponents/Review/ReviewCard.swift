//
//  ReviewCard.swift
//  Catchy
//
//  Created by 권용빈 on 1/23/25.
//

import SwiftUI
import Kingfisher

struct ReviewCard: View {
    
    let data: any ReviewDataProtocol  // ReviewData (내 리뷰) or ReviewContents(평점 리뷰 전체보기)
    let cardType: ReviewCardType      // MyReview or RatingReview
    let reviewType: ReviewType        // Course or Place
    
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
            
            if !data.images.isEmpty {
                // 사진이 있는 경우만 표시
                reviewImages()
            }
            
            reviewContent()             // 리뷰 내용
            
            reviewFooter() // 닉네임 및 방문일
        }
    }
    
    /// 1. 리뷰 상단섹션 : 내 리뷰에서는 장소 or 코스 이름 + 별점 + 삭제 / 평점 리뷰 보기에서는 별점 + 신고하기
    /// - Returns: 리뷰 상단 뷰
    private func cardTopSection() -> some View {
        switch cardType {
        case .myReview:
            return AnyView(
                VStack(alignment: .leading, content: {
                    HStack(content:{
                        Text(data.placeOrCourseName ?? "")
                            .font(.Subtitle3)
                            .foregroundStyle(Color.g7)
                        
                        Spacer()
                        
                        // 신고하기 버튼
                        Button {
                            // 신고하기 로직
                        } label: {
                            Text("삭제")
                                .font(.caption)
                                .foregroundStyle(Color.g5)
                                .underline()
                        }
                    })
                    StarRating(rating: Double(data.rating))
                })
            )
        case .ratingReview:
            return AnyView (
                HStack(content: {
                    // 별점 표시
                    StarRating(rating: Double(data.rating))
                    
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
                ForEach(data.images, id: \.reviewImageId) { image in
                    if let url = URL(string: image.imageUrl) {
                        KFImage(url)
                            .placeholder {
                                ProgressView()
                                    .controlSize(.regular)
                            }.retry(maxCount: 2, interval: .seconds(2))
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
        Text(data.comment.split(separator: "").joined(separator: "\u{200B}"))
            .font(.body2)
            .foregroundColor(.g7)
            .lineLimit(nil)
            .lineSpacing(2)
    }
    
    
    /// 4. 닉네임과 방문일
    /// - Returns: 닉네임과 방문일 뷰
    private func reviewFooter() -> some View {
        switch cardType {
        case .myReview:
            return AnyView(
                HStack(spacing: 6, content: {
                    Text("방문일")
                        .font(.caption)
                        .foregroundStyle(Color.g4)
                    
                    Text(data.visitedDate)
                        .font(.caption)
                        .foregroundStyle(Color.g5)
                })
            )
        case .ratingReview:
            return AnyView(
                HStack(spacing: 6, content: {
                    Text(data.userName ?? "")
                        .font(.caption)
                        .foregroundColor(.g5)
                    
                    // 세로선
                    Rectangle()
                        .fill(.g5)
                        .frame(width: 1, height: 8)
                    
                    Text("방문일")
                        .font(.caption)
                        .foregroundStyle(Color.g4)
                    
                    Text(data.visitedDate)
                        .font(.caption)
                        .foregroundStyle(Color.g5)
                })
            )
        }
    }
}

//#Preview {
//    ReviewCard(data: ReviewContents(reviewId: 1, comment: "안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다.안녕하세요 저는 중앙대학교 학생 정의찬입니다.", rating: 1, reviewImages: [.init(reviewImageId: 1, imageUrl: "https://i.namu.wiki/i/tWggtBqowGk0W5pu6Z9uZi_8qs_iAbdMC573fPCsrFuMPuPuTEiYZDyXGUsCymPqZTNv6gslp9TUsAEQ2v_it3vytlJnMG1Mhdz0bxHUZ2e5u1CJhPn7GsnNx3sLtR77Fx-6EybMT9g2MvJL4NoPlw.webp")], creatorNickname: "dragon", visitedDate: "1111"))
//}
#Preview {
    ReviewCard(data: ReviewData(
        reviewId: 1, name: "스타벅스용산점",
        comment: "안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다.안녕하세요 저는 중앙대학교 학생 정의찬입니다.",
        reviewImages: [ReviewImage(reviewImageId: 101, imageUrl: "https://i.namu.wiki/i/--V4800RVw7ZlVcdBO3Eye-YyvmQv1mghyXYdgYMfE0og0zHAdu3pRpdJptpRSrB5vR1GFu-chsQgxDdYtRXwg.webp"),
                       ReviewImage(reviewImageId: 102, imageUrl: "https://i.namu.wiki/i/nPwiRawmrOrIcfYrdcZ02iKHErrmjUW9uvwzQitt7hf49g1lx6JQB2Q7qguJmjy7jBO41QphiMxw0QurSEF9-Q.webp")],
        rating: 1,
        visitedDate: "2025.01.25"
    ), cardType: .myReview, reviewType: .course)
}

#Preview {
    ReviewCard(data: ReviewContents(
        reviewId: 1,
        comment: "안녕하세요 저는 빈용입니다. 대학생이고요. 제가 여기 가봤는데 너무 좋아요. 다음에도 다시 갈 것 같아요 안녕하세요 저는 빈용입니다. 대학생이고요. 제가 여기 가봤는데 너무 좋아요. 다음에도 다시 갈 것 같아요안녕하세요 저는 빈용입니다. 대학생이고요. 제가 여기 가봤는데 너무 좋아요. 다음에도 다시 갈 것 같아요",
        rating: 3,
        reviewImages: [ReviewImageData(reviewImageId: 101, imageUrl: "https://i.namu.wiki/i/--V4800RVw7ZlVcdBO3Eye-YyvmQv1mghyXYdgYMfE0og0zHAdu3pRpdJptpRSrB5vR1GFu-chsQgxDdYtRXwg.webp"),
                       ReviewImageData(reviewImageId: 102, imageUrl: "https://i.namu.wiki/i/nPwiRawmrOrIcfYrdcZ02iKHErrmjUW9uvwzQitt7hf49g1lx6JQB2Q7qguJmjy7jBO41QphiMxw0QurSEF9-Q.webp")],
        creatorNickname: "빈센",
        visitedDate: "2025.02.01"), cardType: .ratingReview, reviewType: .place
               )
}
