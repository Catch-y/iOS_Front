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
    @Binding var place: PlaceDetailResponse
    
    /// 좋아요 누를 때 액션
    /// nil인 경우 좋아요 못 누름
    let action: (() -> Void)?
    
    init(place: Binding<PlaceDetailResponse>, action: (() -> Void)? = nil) {
        self._place = place
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 19) {
            if let url = URL(string: place.imageUrl) {
                KFImage(url)
                    .placeholder{
                        ProgressView()
                            .controlSize(.large)
                    }
                    .retry(maxCount: 2, interval: .seconds(2))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
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
            HStack(spacing: 10) {
                Text(place.placeName)
                    .font(.Subtitle3)
                    .foregroundStyle(.g7)
                    .lineLimit(1)
                
                CategoryCard(categoryType: place.categoryName)
                    .frame(width: 60)
                
                Spacer()
                
                if action != nil {
                    LikeButton(data: $place, action: action!, forPlace: true)
                    
                }
                
            }
            .padding(.bottom, 8)
            
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
            
            Link(destination: URL(string: place.placeSite )!) {
                PlaceDomainButton(domain: place.placeSite).padding(.leading, 1)
            }
            
        }
        .padding(.horizontal, 11)
        
        
    }
    
}

