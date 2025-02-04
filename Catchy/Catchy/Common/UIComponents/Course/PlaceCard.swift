//
//  PlaceCard.swift
//  Catchy
//
//  Created by LEE on 1/27/25.
//

import SwiftUI
import Kingfisher

struct PlaceCard: View {
    
    var place : PlaceDataProtocol
    
    init(place: PlaceDataProtocol){
        self.place = place
    }
    
    var body: some View {
        
        HStack(spacing: 17) {
            /// 이미지
            if let url = URL(string: place.placeImage) {
                KFImage(url)
                    .placeholder{
                        ProgressView()
                            .controlSize(.regular)
                    }.retry(maxCount: 2, interval: .seconds(2))
                    .resizable()
                    .frame(width: 133, height: 116)
                    .clipShape(RoundedRectangle(cornerRadius: 15)
                    )
            }
            
            placeTextGroup
        }
    }
    
    /// 장소 이름, 카테고리, 위치, 운영 시간을 표시하는 그룹 뷰
    private var placeTextGroup: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            HStack(spacing: 8) {
                /// 장소  이름
                Text(place.placeName.customLineBreak())
                    .font(.Subtitle3_SM)
                    .foregroundStyle(.g7)
                    .lineLimit(1)
                    .padding(.trailing, 8)
                
                /// 장소 카테고리
                CategoryCard(categoryType: place.category)
                    .frame(width: 37.1)
                    .padding(.trailing, 19)
                
                Spacer()
            }
            
            /// 장소 위치
            PlaceAddressText(addressText: place.roadAddress)
                .padding(.top, 6)
            
            /// 장소 운영 시간
            PlaceTimeText(timeText: place.activeTime)
                .padding(.bottom, 8)
            
            HStack(spacing: 12) {
                PlaceRatingText(rating: place.rating)
                placeReviewButton(reviewCount: place.reviewCount)
            }
        }

    }

}

#Preview{
    PlaceCard(place: PlaceSearchResponseData(placeId: 1, placeName: "심퍼티쿠시 용산점", placeImage: "https://static.wanted.co.kr/images/company/21181/dazl35csneuul4f9__1080_790.jpg", category: .RESTAURANT , roadAddress: "서울시 용산구 한강대로52길 17-3 1F", activeTime: "월-금 · 16:00 - 21:00", rating: 4.3, reviewCount: 203)
    )
}
