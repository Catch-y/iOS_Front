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
                placeTitleTage
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
    
    private var placeTitleTage: some View {
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
            makeInfoTitle(Icon.star.image, "평점 \(data.starPoint)")
            
            makeInfoTitle(Icon.star.image, "평점 \(data.starPoint)")
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

struct RecommendPlaceCard_Previews: PreviewProvider {
    static var previews: some View {
        RecommendPlaceCard(data: .constant(RecommendPlaceResponse(placeId: 0, placeImage: "https://i.namu.wiki/i/Q3ru_aVczQgaq1Z1Ptvhktl9fM57cRQkBtn0_DWXyPvXuP3jj8zanjgG_0Cvdim3fN4cXHQ-2QAD2U7opRL9KMb6eWQzo9zpAM9jZA7xxuaMbgF0y08EFC-jcOPgKE5CawVI5g_W_Ku4GmpIL7d5RA.webp", placeName: "심퍼티쿠시 용산점", subCategory: "양식", isLike: false, starPoint: 4.3, placeLocation: "서울시 동작구", placeOperTime: "월-금 16:00 ~ 18:00")))
            .previewLayout(.sizeThatFits)
    }
}
