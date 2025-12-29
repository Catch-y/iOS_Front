//
//  ReviewCard.swift
//  Catchy
//
//  Created by euijjang97 on 12/29/25.
//

import SwiftUI

struct ReviewCard: View, Equatable {

    let rating: Double?
    let images: [UIImage]
    let comment: String
    let nickname: String
    let visitDate: String?
    let reviewCreateDate: String?

    let action: () -> Void

    static func == (lhs: ReviewCard, rhs: ReviewCard) -> Bool {
        lhs.rating == rhs.rating &&
        lhs.images == rhs.images &&
        lhs.comment == rhs.comment &&
        lhs.nickname == rhs.nickname &&
        lhs.visitDate == rhs.visitDate &&
        lhs.reviewCreateDate == rhs.reviewCreateDate
    }

    private enum Constants {
        static let spacing: CGFloat = 12
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.spacing, content: {
            topTag
            ReviewCardForm(images: images, text: comment, nickname: nickname, visitDate: visitDate, reviewCreateDate: reviewCreateDate)
                .equatable()
        })
    }
    
    @ViewBuilder
    private var topTag: some View {
        HStack(alignment: .firstTextBaseline) {
            if let rating = rating {
                ReviewStars(rating: .constant(Int(rating.rounded())), size: .init(width: 18, height: 18))
            } else {
                Text(nickname)
                    .font(.caption)
                    .foregroundStyle(.g5)
            }
            
            Spacer()
            
            Button(action: {
                action()
            }, label: {
                Text("신고하기")
                    .underline()
                    .font(.caption1)
                    .foregroundStyle(.g6)
            })
        }
    }
}

#Preview {
    ReviewCard(rating: 4.5, images: .init(), comment: "친구들과 함께한 코스였는데, 모든 장소가 만족스러웠어요. 특히 마지막 카페가 최고!", nickname: "제옹", visitDate: "2025.12.25", reviewCreateDate: nil, action: {
        print("hello")
    })
}
