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
            .frame(width: 165, height: 91)
        })
    }
    
    private var placeImage: some View {
        ZStack(alignment: .topLeading, content: {
            
            if let url = URL(string: data.placeImage) {
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
                print("장소 좋아요 클릭")
            })
            .padding(.leading, 8)
            .padding(.top, 6)
        })
    }
    
    private var placeTitleTag: some View {
        HStack(spacing: 15 ,content: {
            Text(data.placeName)
                .font(.body1)
                .foregroundStyle(Color.g7)
                .frame(width: 107, alignment: .leading)
            
            Text(data.subCategory)
                .font(.courseTag)
                .foregroundStyle(Color.g6)
                .padding(.vertical, 4)
                .padding(.horizontal, 13)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(Color.g2)
                }
        })
    }
    
    private var placePointInfo: some View {
        HStack(spacing: 8, content: {
            StarPoint(point: data.starPoint)
            
            ReviewComponent(reviewCount: data.reviewCnt)
        })
    }
    
    private var placeLocationInfo: some View {
        VStack(alignment: .leading, spacing: 6, content: {
            makeInfoTitle(Icon.location.image, data.placeLocation)
            
            makeInfoTitle(Icon.time.image, data.placeOperTime)
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
}
