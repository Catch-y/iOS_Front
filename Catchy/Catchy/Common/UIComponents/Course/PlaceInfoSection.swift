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
    
    /// 북마크 할 수 있는가?
    let canBookmark: Bool
    
    init(place: PlaceDetailResponse, canBookmark: Bool = false) {
        self.place = place
        self.canBookmark = canBookmark
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
                
                // TODO: - 북마크 Swagger 수정 후 작성
                if canBookmark {
                    Button(action: { }, label: {
                        
                        Icon.empyHeart.image
                            .resizable()
                            .frame(width: 16, height: 16)
                    })
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

#Preview {
    PlaceInfoSection(place: .init(placeId: 1, imageUrl: "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg", placeName: "중앙대학교", placeDescription: "넓고 큰 중앙대학교", categoryName: .BAR, roadAddress: "도로명 주소 ㅇㅇ", activeTime: "dsds~dsds", rating: 4.2, isVisited: false, reviewCount: 53, placeSite: "www.naver.com"))
}
