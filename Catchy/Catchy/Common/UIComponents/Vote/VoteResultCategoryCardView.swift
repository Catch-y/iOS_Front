//
//  VoteResultCategoryCardView.swift
//  Catchy
//
//  Created by 임소은 on 2/10/25.
//

import SwiftUI
import Moya

struct VoteResultCategoryCardView: View {
    @ObservedObject var viewModel: VoteResultCategoryCardViewModel

    var body: some View {
        ForEach(viewModel.places, id: \ .placeId) { place in
            VoteResultCategoryCardContentView(place: place, isBookmarked: viewModel.isBookmarked) {
                viewModel.toggleBookmark()
            }
            .padding()
            .background(Color(.white))
        }
    }
}

// MARK: - Card Content View
struct VoteResultCategoryCardContentView: View {
    let place: PlaceResponse
    let isBookmarked: Bool
    let onBookmarkToggle: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // 가게 이미지
            Image(place.imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: 133, height: 99)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 2)

            // 콘텐츠 부분
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    // 가게 이름
                    Text(place.placeName)
                        .font(.body1)
                        .lineLimit(1)
                    Spacer()
                    // 하트 버튼
                    Button(action: onBookmarkToggle) {
                        (isBookmarked ? Icon.heart.image : Icon.empyHeart.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                    }
                }
                
                // 평점 및 리뷰
                HStack(spacing: 4) {
                    Icon.star.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)

                    Text("평점: \(String(format: "%.1f", place.rating))")
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                    
                    Icon.review.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)

                    Text("리뷰 \(place.reviewCount)개")
                        .font(.caption)
                        .foregroundStyle(Color.g4)
                }

                // 프로필 이미지
                HStack(spacing: 4) {
                    Icon.circleHeart.image
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                    
                    ForEach(place.votedMembers, id: \ .memberId) { member in
                        Image(member.profileImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 23, height: 23)
                            .clipShape(Circle())
                    }
                }
            }
        }
    }
}
// MARK: - Preview
struct VoteResultCategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = VoteResultCategoryCardViewModel(groupId: 1, category: "카페", useSampleData: true)

        return VoteResultCategoryCardView(viewModel: viewModel)
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDevice("iPhone 16 Pro")
    }
}
