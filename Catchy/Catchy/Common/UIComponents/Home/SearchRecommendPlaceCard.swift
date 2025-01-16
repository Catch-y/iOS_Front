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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    @ViewBuilder
    private var placeImage: some View {
        if let url = URL(string: data.placeImage) {
            KFImage(url)
                .placeholder {
                    ProgressView()
                        .controlSize(.regular)
                }.retry(maxCount: 2, interval: .seconds(2))
                .resizable()
                .frame(width: 133, height: 116)
                .clipShape(.rect(cornerRadius: 15))
        }
    }
    
    private var placeLocationInfo: some View {
        VStack(alignment: .center, spacing: 6, content: {
            makeInfoTitle(Icon.location.image, data.roadAddress)
            
            makeInfoTitle(Icon.time.image, data.activeTime)
        })
    }
    
    private var placePointInfo: some View {
        HStack(spacing: 12, content: {
            StarPoint(point: data.averageRating)
            
            ReviewComponent(reviewCount: data.reviewCount)
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
