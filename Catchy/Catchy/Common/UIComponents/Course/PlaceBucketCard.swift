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
    
    /// 장소 모델
    var placeSearchResponseData: PlaceDataProtocol
    
    /// 현재 장소의 인덱스
    let index: Int
    
    /// X 버튼 탭시 실행
    var closeButtonTap: ((Int) -> Void)
    
    
    let canDelete: Bool
    
    init(placeSearchResponseData: PlaceDataProtocol, index: Int, closeButtonTap: @escaping (Int) -> Void, canDelete: Bool = true) {
        self.placeSearchResponseData = placeSearchResponseData
        self.index = index
        self.closeButtonTap = closeButtonTap
        self.canDelete = canDelete
    }
    
    var body: some View {
        
            
        HStack(alignment: .top, spacing: 10) {
            
            /// 장소 순서 레이블
            numberingLabel
            
            /// 이미지
            if let url = URL(string: placeSearchResponseData.placeImage) {
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
            if canDelete { closeButton }
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
                CategoryCard(categoryType: placeSearchResponseData.category)
                    .frame(width: 40)
                
                Text(placeSearchResponseData.placeName)
                    .font(.Subtitle3_SM)
                    .foregroundStyle(.g7)
                    .lineLimit(1)
        

            }.padding(.bottom, 6)

            
            /// 장소 주소
            PlaceAddressText(addressText: placeSearchResponseData.roadAddress)
                
            /// 장소 영업시간
            PlaceTimeText(timeText: placeSearchResponseData.activeTime)
            
            HStack(spacing: 12) {
                
                /// 장소 평점
                PlaceRatingText(rating: placeSearchResponseData.rating)
                
                /// 장소 리뷰 버튼
                placeReviewButton(reviewCount: placeSearchResponseData.reviewCount)
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

