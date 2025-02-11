//
//  PlaceInfoSection.swift
//  Catchy
//
//  Created by LEE on 1/28/25.
//

import SwiftUI
import Kingfisher

struct PlaceInfoSection: View {
    
    /// 장소 상세 정보 데이터
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
    
    
    /// 장소 상세 화면 텍스트 그룹
    private var placeTextGroup: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(place.placeName)
                    .font(.Subtitle3)
                    .foregroundStyle(.g7)
                    .lineLimit(1)
                    .padding(.bottom, 6)
                
                Spacer()
                
                CategoryCard(categoryType: place.categoryName)
                    .frame(width: 60)
            }
            .padding(.bottom, 2)
            
            Text(place.placeDescription)
                .font(.body3)
                .foregroundStyle(.g4)
                

            HStack(spacing: 12) {
                
                PlaceRatingText(rating: place.rating)
                
                placeReviewButton(reviewCount: place.reviewCount)
            }
            .padding(.top, 14)
            
            Divider()
                .padding(.vertical, 20)
                .foregroundStyle(.g2)
            
            PlaceAddressText(addressText: place.roadAddress)
                .padding(.bottom, 4)
            
            PlaceTimeText(timeText: place.activeTime)
                .padding(.bottom, 4)
            
            PlaceDomainButton(domain: place.placeSite).padding(.leading, 1)
        }
        .padding(.horizontal, 11)
        
        
    }
    
}
