//
//  PlaceBucketCard.swift
//  Catchy
//
//  Created by LEE on 2/6/25.
//

import SwiftUI
import Kingfisher

struct PlaceBucketCard: View {
    
    /// 애니메이션 변수
    @State private var isRemoved = false
    
    /// 장소 상세정보 모델
    var placeDetailResponse: PlaceDetailResponse
    
    /// 현재 장소의 인덱스
    let index: Int
    
    /// X 버튼 탭시 실행
    var closeButtonTap: ((Int) -> Void)
    
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
            
            Spacer()
            
            /// X 버튼
            closeButton
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
        .offset(x: isRemoved ? 1000 : 0)
        .animation(.easeInOut(duration: 0.5), value: isRemoved)

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
            
            Text(String(index + 1))
                .foregroundStyle(.main)
                .font(.body1)
            
        }
        .frame(width: 16, height: 40)

    }
    
    /// X 버튼
    private var closeButton: some View {
        
        Button(action: {
            withAnimation(.easeInOut(duration: 0.3)) {
                isRemoved = true
            }
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.bouncy(extraBounce: 0.03)) {
                    closeButtonTap(index)

                }
            }
            
        }, label: {
            Icon.close.image
                .resizable()
                .frame(width: 12, height: 12)
        })
        .padding(.top, -6)
    }
}

