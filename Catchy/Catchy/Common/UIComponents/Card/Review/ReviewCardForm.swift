//
//  ReviewCard.swift
//  Catchy
//
//  Created by euijjang97 on 12/29/25.
//

import SwiftUI

struct ReviewCardForm: View, Equatable {

    // MARK: - Property
    let images: [UIImage]
    let text: String
    let nickname: String
    let visitDate: String?
    let reviewCreateDate: String?

    // MARK: - Constants
    private enum Constants {
        static let mainVspacing: CGFloat = 16
        static let padding: EdgeInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        static let cornerRadius: CGFloat = 15
    }

    // MARK: - Equatable
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.images == rhs.images &&
        lhs.text == rhs.text &&
        lhs.nickname == rhs.nickname &&
        lhs.visitDate == rhs.visitDate &&
        lhs.reviewCreateDate == rhs.reviewCreateDate
    }

    // MARK: - Init
    init(
        images: [UIImage] = [],
        text: String,
        nickname: String,
        visitDate: String? = nil,
        reviewCreateDate: String? = nil
    ) {
        self.images = images
        self.text = text
        self.nickname = nickname
        self.visitDate = visitDate
        self.reviewCreateDate = reviewCreateDate
    }

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.mainVspacing) {
            if !images.isEmpty {
                ReviewImages(images: images)
            }

            ReviewTextContent(
                text: text,
                nickname: nickname,
                visitDate: visitDate,
                reviewCreateDate: reviewCreateDate
            )
        }
    }
}

/// 리뷰 이미지 스크롤 뷰
fileprivate struct ReviewImages: View, Equatable {
    
    let images: [UIImage]
    
    private enum Constants {
        static let imageSize: CGFloat = 85
        static let cornerRadius: CGFloat = 15
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.images == rhs.images
    }
    
    // MARK: - Init
    init(images: [UIImage]) {
        self.images = images
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: Constants.imageSize, height: Constants.imageSize)
                        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                }
            }
        }
    }
}

// MARK: - ReviewTextContent
fileprivate struct ReviewTextContent: View, Equatable {
    
    let text: String
    let nickname: String
    let visitDate: String?
    let reviewCreateDate: String?
    
    init(
        text: String,
        nickname: String,
        visitDate: String?,
        reviewCreateDate: String? = nil
    ) {
        self.text = text
        self.nickname = nickname
        self.visitDate = visitDate
        self.reviewCreateDate = reviewCreateDate
    }
    
    private enum Constants {
        static let spacing: CGFloat = 6
        static let mainVspacing: CGFloat = 14
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.mainVspacing, content: {
            Text(text)
                .font(.body2)
                .foregroundStyle(.g7)
                .lineLimit(nil)
            
            if let visitDate = visitDate {
                placeBottomInfo(visitDate: visitDate)
            }
            
            if let reviewCreateDate = reviewCreateDate {
                courseBottomInfo(labelValue: reviewCreateDate)
            }
        })
    }
    
    @ViewBuilder
    private func placeBottomInfo(visitDate: String) -> some View {
        HStack(spacing: Constants.spacing, content: {
            Text(nickname)
            
            Divider()
                .foregroundStyle(.g5)
                .frame(height: 8)
                
            dateLabel(label: "방문일", labelValue: visitDate)
        })
        .font(.caption)
        .foregroundStyle(.g5)
    }
    
    @ViewBuilder
    private func courseBottomInfo(labelValue: String) -> some View {
        dateLabel(label: "리뷰 작성일", labelValue: labelValue)
    }
    
    private func dateLabel(label: String, labelValue: String) -> some View {
        HStack(spacing: Constants.spacing, content: {
            Text(label)
                .foregroundStyle(.g4)

            Text(labelValue)
                .foregroundStyle(.g5)
        })
        .font(.caption)
    }
}

// MARK: - Preview
#Preview("장소 리뷰") {
    ReviewCardForm(
        text: "분위기가 정말 좋고 음식도 맛있었어요! 다음에 또 방문하고 싶습니다.",
        nickname: "맛집탐험가",
        visitDate: "2025.12.25"
    )
}

#Preview("코스 리뷰") {
    ReviewCardForm(
        text: "친구들과 함께한 코스였는데, 모든 장소가 만족스러웠어요. 특히 마지막 카페가 최고!",
        nickname: "여행러버",
        reviewCreateDate: "2025.12.28"
    )
}
