//
//  ReviewCard.swift
//  Catchy
//
//  Created by 권용빈 on 1/23/25.
//

import SwiftUI
import Kingfisher

struct ReviewCard: View {
    
    let data: ReviewContents
    
    init(data: ReviewContents) {
        self.data = data
    }
    
    var body: some View {
        reviewTableSection(content: data)
    }
    
    // MARK: - 리뷰 테이블 카드

    
    /// 리뷰 테이블 섹션
    /// - Parameter content: 리뷰 내용 데이터 모델
    /// - Returns: 리뷰 카드 뷰
    private func reviewTableSection(content: ReviewContents) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            ratingAndReport(rating: content.rating) // 별점 및 신고하기 버튼
            
            if !content.reviewImages.isEmpty {
                // 사진이 있는 경우만 표시
                reviewImages(images: content.reviewImages)
            }
            
            reviewContent(comment: content.comment)             // 리뷰 내용
            
            reviewFooter(nickname: content.creatorNickname, visitedDate: content.visitedDate) // 닉네임 및 방문일
        }
    }

    /// 1. 별점 및 신고하기 버튼
    /// - Parameter rating: 리뷰의 별점 (Int)
    /// - Returns: 별점 및 신고하기 버튼 뷰
    private func ratingAndReport(rating: Int) -> some View {
        HStack {
            // 별점 표시
            StarRating(rating: Double(rating))
            
            Spacer()
            
            // 신고하기 버튼
            Text("신고하기")
                .font(.caption)
                .foregroundColor(.g5)
                .underline()
        }
    }

    
    /// 2. 리뷰 이미지
    /// - Parameter images: 리뷰 이미지 데이터 배열
    /// - Returns: 리뷰 이미지 뷰
    private func reviewImages(images: [ReviewImageData]) -> some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: Array(repeating: GridItem(.fixed(85)), count: 1), spacing: 6, content: {
                placeImage(images: images)
            })
            .padding(.trailing, 10)
        }
        .frame(height: 85)
    }
    
    @ViewBuilder
    private func placeImage(images: [ReviewImageData]) -> some View {
        ForEach(images, id: \.reviewImageId) { image in
            if let url = URL(string: image.imageUrl) {
                KFImage(url)
                    .placeholder {
                        ProgressView()
                            .controlSize(.regular)
                    }.retry(maxCount: 2, interval: .seconds(2))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 85, height: 85)
                    .clipShape(.rect(cornerRadius: 15))
            }
        }
    }
    
    /// 3. 리뷰 내용
    /// - Parameter comment: 리뷰 내용 텍스트
    /// - Returns: 리뷰 내용 뷰
    private func reviewContent(comment: String) -> some View {
        Text(comment.split(separator: "").joined(separator: "\u{200B}"))
            .font(.body2)
            .foregroundColor(.g7)
            .lineLimit(nil)
            .lineSpacing(2)
    }

    
    /// 4. 닉네임과 방문일
    /// - Parameters:
    ///   - nickname: 작성자 닉네임
    ///   - visitedDate: 방문일 텍스트
    /// - Returns: 닉네임과 방문일 뷰
    private func reviewFooter(nickname: String, visitedDate: String?) -> some View {
        HStack {
            Text(nickname)
                .font(.caption)
                .foregroundColor(.g5)
            
            // 세로선
            Rectangle()
                .fill(.g5)
                .frame(width: 1, height: 8)
            
            Text("방문일 \(visitedDate ?? "모름")")
                .font(.caption)
                .foregroundColor(.g4)
        }
    }


}

//#Preview {
//    ReviewCard(data: ReviewContents(reviewId: 1, comment: "안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다.안녕하세요 저는 중앙대학교 학생 정의찬입니다.", rating: 1, reviewImages: [.init(reviewImageId: 1, imageUrl: "https://i.namu.wiki/i/tWggtBqowGk0W5pu6Z9uZi_8qs_iAbdMC573fPCsrFuMPuPuTEiYZDyXGUsCymPqZTNv6gslp9TUsAEQ2v_it3vytlJnMG1Mhdz0bxHUZ2e5u1CJhPn7GsnNx3sLtR77Fx-6EybMT9g2MvJL4NoPlw.webp")], creatorNickname: "dragon", visitedDate: "1111"))
//}
#Preview {
    ReviewCard(data: ReviewContents(
        reviewId: 1,
        comment: "안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다. 안녕하세요 저는 중앙대학교 학생 정의찬입니다.안녕하세요 저는 중앙대학교 학생 정의찬입니다.",
        rating: 1,
        reviewImages: [], // 사진이 없는 경우
        creatorNickname: "dragon",
        visitedDate: "1111"
    ))
}
