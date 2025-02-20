//
//  VoteResultCategoryCardView.swift
//  Catchy
//
//  Created by 임소은 on 2/10/25.
//

import SwiftUI
import Moya
import Kingfisher

struct VoteResultCategoryCardView: View {
    @ObservedObject var viewModel: VoteResultCategoryCardViewModel

    var body: some View {
        ForEach(viewModel.places, id: \.placeId) { place in
            VoteResultCategoryCardContentView(
                place: place,
                isBookmarked: viewModel.isBookmarked(place.placeId),  //  개별 북마크 상태 적용
                onBookmarkToggle: {
                    viewModel.toggleBookmark(for: place.placeId)  //  해당 장소의 북마크 상태만 변경
                }
            )
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
            // ✅ Kingfisher를 사용하여 가게 이미지 로드
            KFImage(URL(string: place.imageUrl))
                .resizable()
                .placeholder {
                    Color.g3 // 이미지 로딩 중일 때 회색 배경 표시
                }
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
                            .frame(width: 20, height: 20)
                    }
                }
                
                // 평점 및 리뷰
                HStack(spacing: 5) {
                    Icon.star.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)

                    Text("평점: \(String(format: "%.1f", place.rating))")
                        .font(.caption)
                        .foregroundStyle(Color.g4)
                    
                    Icon.review.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)

                    Text("리뷰 \(place.reviewCount)개")
                        .font(.caption)
                        .foregroundStyle(Color.g4)
                }

                //  Kingfisher를 사용하여 프로필 이미지 로드
                HStack(spacing: 4) {
                    
                    Icon.circleHeart.image
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                    
                    ForEach(place.votedMembers, id: \.memberId) { member in
                        KFImage(URL(string: member.profileImage))
                            .resizable()
                            .placeholder {
                                ProgressView()
                                    .controlSize(.regular)
                            }
                            .scaledToFill()
                            .frame(width: 23, height: 23)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.white, lineWidth: 1)
                            )
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct VoteResultCategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro Max", "iPhone 11"], id: \.self) { deviceName in
            NavigationView {
                VoteResultCategoryCardView(viewModel: VoteResultCategoryCardViewModel(groupId: 1, category: "카페", useSampleData: true))
            }
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
