//
//  PlaceCard.swift
//  Catchy
//
//  Created by LEE on 1/27/25.
//

import SwiftUI
import Kingfisher

struct PlaceCard: View {
    
    // MARK: - Properties
    /// 장소 데이터
    var place : PlaceDataProtocol
    
    /// 리뷰 버튼 탭 시 호출
    let reviewTap: () -> Void
    
    // MARK: - Init
    init(place: PlaceDataProtocol, reviewTap: @escaping () -> Void){
        self.place = place
        self.reviewTap = reviewTap
    }
    
    var body: some View {
        
        HStack(spacing: 17) {
            if let url = URL(string: place.placeImage ?? "") {
                KFImage(url)
                    .placeholder{
                        ProgressView()
                            .controlSize(.regular)
                    }.retry(maxCount: 2, interval: .seconds(2))
                    .downsampling(size: CGSize(width: UIScreen.screenWidth, height: 116))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
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
                
                Text(place.placeName.customLineBreak())
                    .font(.Subtitle3_SM)
                    .foregroundStyle(.g7)
                    .lineLimit(1)
                    .padding(.trailing, 8)
                
                Spacer()

                if let category = place.category {
                    CategoryCard(categoryType: category)
                        .frame(width: 37.1)
                        .padding(.trailing, 19)
                }
            }
            .padding(.bottom, 6)
            
            PlaceAddressText(addressText: place.roadAddress)
                .padding(.top, 6)
            
            if let activeTime = place.activeTime {
                PlaceTimeText(timeText: activeTime)
                    .padding(.bottom, 8)
            }
            
            
            HStack(spacing: 12) {
                PlaceRatingText(rating: place.rating)
                reviewButton
            }
        }

    }
    
    /// 장소 리뷰 버튼
    private var reviewButton: some View {
        
        Button(action: { reviewTap()}, label: {
            HStack(spacing: 6) {
                Icon.review.image.fixedSize()
                
                Text("리뷰 \(place.reviewCount)개")
                    .font(.caption)
                    .foregroundStyle(.g5)
                    .lineLimit(1)

                
                Icon.rightChevron.image.resizable()
                    .frame(width: 4, height: 8)
            }
        })
        
    }

}

//#Preview{
//    PlaceCard(place: PlaceSearchResponseData(placeId: 1, placeName: "심퍼티쿠시 용산점", placeImage: "https://static.wanted.co.kr/images/company/21181/dazl35csneuul4f9__1080_790.jpg", category: .RESTAURANT , roadAddress: "서울시 용산구 한강대로52길 17-3 1F", activeTime: "월-금 · 16:00 - 21:00", rating: 4.3, reviewCount: 203)
//    )
//}
