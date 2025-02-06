//
//  PlaceBucketCard.swift
//  Catchy
//
//  Created by LEE on 2/6/25.
//

import SwiftUI
import Kingfisher

struct PlaceBucketCard: View {
    
    /// 장소 상세정보 모델
    let placeDetailResponse: PlaceDetailResponse
    
    /// X 버튼 탭시 실행
    var closeButtonTap: ((PlaceDetailResponse) -> Void)?
    
    var body: some View {
        
            
        HStack(alignment: .top, spacing: 10) {
            
            /// 장소 순서 레이블
            numberingLabel
            
            /// 이미지
            if let url = URL(string: placeDetailResponse.imageUrl) {
                KFImage(url)
                    .placeholder{
                        ProgressView()
                            .controlSize(.regular)
                    }
                    .retry(maxCount: 2, interval: .seconds(2))
                    .resizable()
                    .frame(maxWidth: 90, maxHeight: 116)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
                
            /// 텍스트 그룹
            textGroup
                
            /// X 버튼
            Button(action: {
                closeButtonTap?(placeDetailResponse)
            }, label: {
                Icon.close.image
                    .resizable()
                    .frame(width: 12, height: 12)
            })
            .padding(.top, -6)
                
        }
        .padding(.bottom, 20)
        .padding(.top, 26)
        .padding(.trailing, 17)
        .padding(.leading, 10)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .s1w()
        }
        .frame(height: 168)
        .frame(maxWidth: .infinity)
        
        
        
    }
    
    /// 텍스트 그룹
    private var textGroup: some View {
        VStack(alignment: .leading) {
            HStack{
                
                /// 카테고리 카드
                CategoryCard(categoryType: placeDetailResponse.categoryName)
                    .frame(width: 40)
                
                Text(placeDetailResponse.placeName)
                    .font(.Subtitle3_SM)
                    .foregroundStyle(.g7)
                    .lineLimit(1)
                
            }
            
            /// 장소 주소
            PlaceAddressText(addressText: placeDetailResponse.roadAddress)
            
            /// 장소 영업시간
            PlaceTimeText(timeText: placeDetailResponse.activeTime)
            
            HStack(spacing: 12) {
                
                /// 장소 평점
                PlaceRatingText(rating: placeDetailResponse.rating)
                
                /// 장소 리뷰 버튼
                placeReviewButton(reviewCount: placeDetailResponse.reviewCount)
            }
            .padding(.top, 8)
        }
        .padding(.top, 8)
    
    }
    
    /// 장소 순서 레이브
    private var numberingLabel: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 7.5)
                .fill(Color.white)
                .stroke(.main)
            
            Text("1")
                .foregroundStyle(.main)
                .font(.body1)
            
        }
        .frame(width: 16, height: 40)
    }
}

struct PlaceBucketCard_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(
            ["iPhone 16 Pro Max", "iPhone 11 Pro", "iPhone 12 mini"],
            id: \.self
        ) { deviceName in
            PlaceBucketCard(
                placeDetailResponse: .init(
                    placeId: 1,
                    imageUrl: "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                    placeName: "심퍼티쿠시 용산점",
                    placeDescription: "유러피언 요리를 아시안 스타일로 풀어내는 파인캐주얼 레스토랑",
                    categoryName: .CULTURELIFE,
                    roadAddress: "경기 남양주시 외부읍 덕소로 2번길 84",
                    activeTime: "[영업시간] 매일 09:00~22:00",
                    rating: 3,
                    isVisited: true,
                    reviewCount: 21,
                    placeSite: "www.naver.com"
                )
            )
            .previewLayout(.sizeThatFits)
            .previewDisplayName(deviceName)
        }
    }
}

