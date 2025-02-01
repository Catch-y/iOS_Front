//
//  PlaceInfoSection.swift
//  Catchy
//
//  Created by LEE on 1/28/25.
//

import SwiftUI
import Kingfisher

struct PlaceInfoSection: View {
    
    var place: PlaceDetailResponse
    
    init(place: PlaceDetailResponse) {
        self.place = place
    }
    
    var body: some View{
        VStack(spacing: 19) {
            if let url = URL(string: place.imageUrl) {
                KFImage(url)
                    .placeholder{
                        ProgressView()
                            .controlSize(.large)
                    }
                    .retry(maxCount: 2, interval: .seconds(2))
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 144)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            placeTextGroup
        }
        .safeAreaPadding(.horizontal, 16)
    }
    
    
    private var placeTextGroup: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                /// 장소 이름
                Text(place.placeName)
                    .font(.Subtitle3)
                    .foregroundStyle(.g7)
                    .lineLimit(1)
                    .padding(.bottom, 6)
                
                Spacer()
                
                /// 장소 카테고리
                CategoryCard(categoryType: place.categoryName)
                    .frame(width: 60)
            }
            .padding(.bottom, 2)
            
            /// 장소 설명
            Text(place.placeDescription)
                .font(.body3)
                .foregroundStyle(.g4)
                

            HStack(spacing: 12) {
                
                /// 장소 평점
                PlaceRatingText(rating: place.rating)
                
                /// 장소 리뷰
                placeReviewButton(reviewCount: place.reviewCount)
            }
            .padding(.top, 14)
            
            Divider()
                .padding(.vertical, 20)
                .foregroundStyle(.g2)
            
            /// 장소 주소
            PlaceAddressText(addressText: place.roadAddress)
                .padding(.bottom, 4)
            
            /// 장소 운영 시간
            PlaceTimeText(timeText: place.activeTime)
                .padding(.bottom, 4)
            
            /// 장소 도메인 주소
            PlaceDomainButton(domain: place.placeSite).padding(.leading, 1)
        }
        .padding(.horizontal, 11)
        
        
    }
    
}
