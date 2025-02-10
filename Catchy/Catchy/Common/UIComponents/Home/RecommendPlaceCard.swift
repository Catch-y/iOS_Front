//
//  RecommendPlaceCard.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import SwiftUI
import Kingfisher

struct RecommendPlaceCard: View {
    
    @Binding var data: RecommendPlaceResponse
    
    var body: some View {
        HStack(spacing: 14, content: {
            placeImage
            
            VStack(alignment: .leading, content: {
                placeTitleTag
                placePointInfo
                placeLocationInfo
                    .padding(.top, 11)
            })
        })
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var placeImage: some View {
        ZStack(alignment: .topLeading, content: {
            
            if let url = URL(string: data.placeImageUrl) {
                KFImage(url)
                    .placeholder {
                        ProgressView()
                            .controlSize(.regular)
                    }.retry(maxCount: 2, interval: .seconds(2))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 149, height: 103)
                    .clipShape(.rect(cornerRadius: 15))
            }
            
            LikeButton(data: $data, action: {
                //TODO: - Like API 연결
                print("장소 좋아요 클릭")
            })
            .padding(.leading, 8)
            .padding(.top, 6)
        })
    }
    
    private var placeTitleTag: some View {
        HStack(spacing: 8, content: {
            Text(data.placeName)
                .font(.body1)
                .foregroundStyle(Color.g7)
            
            Text(data.category)
                .font(.courseTag)
                .foregroundStyle(Color.g6)
                .padding(.vertical, 4)
                .padding(.horizontal, 13)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(Color.g2)
                }
        })
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var placePointInfo: some View {
        HStack(spacing: 8, content: {
            makeInfoTitle(Icon.star.image, "평점 \(data.averageRating)")
            
            makeReview(Icon.review.image, "리뷰 \(data.reviewCount)개", Icon.rightChevron.image)
        })
    }
    
    private var placeLocationInfo: some View {
        VStack(alignment: .leading, spacing: 6, content: {
            makeInfoTitle(Icon.location.image, data.roadAddress)
            
            makeInfoTitle(Icon.time.image, data.activeTime)
        })
    }
    
}

extension RecommendPlaceCard {
    func makeInfoTitle(_ image: Image, _ title: String) -> some View {
        HStack(spacing: 5, content: {
            image
                .fixedSize()
            
            Text(title)
                .font(.caption)
                .foregroundStyle(Color.g4)
        })
    }
    
    func makeReview(_ leftImage: Image, _ title: String, _ rightImage: Image) -> some View {
        HStack(spacing: 6, content: {
            leftImage
                .fixedSize()
            Text(title)
                .font(.caption)
                .foregroundStyle(Color.g4)
            
            rightImage
                .fixedSize()
        })
    }
}

struct RecommendPlaceCard_Preview: PreviewProvider {
    static var previews: some View {
        RecommendPlaceCard(data: .constant(RecommendPlaceResponse(placeId: 0, placeImageUrl: "https://i.namu.wiki/i/Ca6uA8jti6jQfstU5FzeSH6bnn9Ms8uoWBMROytYU606IZ0GLj4d8RWEAQpV3PUP1FjsuemL2y-QlMwp-m1JiQl-ZXmKvkKDfsFNK93VrWiFP9Tv7Yz71eOmMJnBKGHfQEFIfGODpVi3lwxEll8eAw.webp", category: "영화", placeName: "삼퍼티쿠시 용산점", roadAddress: "서울시 동작구", activeTime: "월-금 16:00 - 21:00", reviewCount: 203, averageRating: 4.3, isLike: false)))
    }
}
