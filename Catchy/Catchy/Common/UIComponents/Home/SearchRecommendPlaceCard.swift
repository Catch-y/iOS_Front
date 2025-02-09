//
//  SearchRecommendPlaceCard.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import SwiftUI
import Kingfisher

struct SearchRecommendPlaceCard: View {
    
    let data: SearchPlaceData
    
    var body: some View {
        HStack(spacing: 17, content: {
            placeImage
            
            VStack(alignment: .leading, content: {
                placeNameInfo
                
                placeLocationInfo
                    .padding(.top, 12)
                
                placePointInfo
                    .padding(.top, 13)
                
            })
        })
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private var placeImage: some View {
        if let url = URL(string: data.placeImageUrl) {
            KFImage(url)
                .placeholder {
                    ProgressView()
                        .controlSize(.regular)
                }.retry(maxCount: 2, interval: .seconds(2))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 133, height: 116)
                .clipShape(.rect(cornerRadius: 15))
        }
    }
    
    private var placeNameInfo: some View {
        HStack(alignment: .firstTextBaseline, spacing: 8, content: {
            Text(data.placeName)
                .font(.Subtitle3)
                .foregroundStyle(Color.g7)
                .lineLimit(1)
                .layoutPriority(1)
            
            CategoryCard(categoryType: data.searchedPlaceCategory)
                .frame(minWidth: 50, maxWidth: 100)
                .fixedSize()

        })
    }
    
    private var placeLocationInfo: some View {
        VStack(alignment: .leading, spacing: 6, content: {
            makeInfoTitle(Icon.location.image, data.roadAddress)
            
            makeInfoTitle(Icon.time.image, data.activeTime)
        })
    }
    
    private var placePointInfo: some View {
        HStack(spacing: 12, content: {
            makeInfoTitle(Icon.star.image, "평점 \(data.averageRating)")
            
            makeReview(Icon.time.image, "리뷰 \(data.reviewCount)개", Icon.rightChevron.image)
        })
    }
}

extension SearchRecommendPlaceCard {
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
