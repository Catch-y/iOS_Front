//
//  PlaceBucketCard.swift
//  Catchy
//
//  Created by LEE on 2/6/25.
//

import SwiftUI
import Kingfisher

struct PlaceBucketCard: View {
    
    @EnvironmentObject var container: DIContainer
    
    // MARK: - Properties
    /// 애니메이션 변수
    @State private var isRemoved = false
    
    /// 장소 모델
    var placeSearchResponseData: PlaceDataProtocol
    
    /// 현재 장소의 인덱스
    let index: Int
    
    /// X 버튼 탭시 실행
    var closeButtonTap: (() -> Void)
    
    /// 지울 수 있는지
    let canDelete: Bool
    
    // MARK: - 장소 리뷰 화면 Properties
    /// 장소 리뷰 보기 화면 상태
    @State var isReviewPresented: Bool = false
        
    // MARK: - Init
    /// 클로즈 버튼이 없으면, 삭제 기능 X
    init(placeSearchResponseData: PlaceDataProtocol, index: Int, canDelete: Bool = true, closeButtonTap: @escaping () -> Void) {
        self.placeSearchResponseData = placeSearchResponseData
        self.index = index
        self.closeButtonTap = closeButtonTap
        self.canDelete = canDelete
    }
    
    var body: some View {
        
            
        HStack(alignment: .top, spacing: 10) {
            
            numberingLabel
            
            if let url = URL(string: DataFormatter.shared.formattedImageUrl(placeImageURL: placeSearchResponseData.placeImage ?? "")) {
                KFImage(url)
                    .placeholder{
                        ProgressView()
                            .controlSize(.regular)
                    }
                    .retry(maxCount: 2, interval: .seconds(2))
                    .downsampling(size: CGSize(width: UIScreen.screenWidth, height: 103))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 90, maxHeight: 116)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
                
            textGroup
            
            Spacer()
            
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
        .animation(.linear(duration: 0.3), value: isRemoved)
        
        

    }
    
    /// 텍스트 그룹
    private var textGroup: some View {
        VStack(alignment: .leading) {
            HStack{
                
                if let category = placeSearchResponseData.category {
                    CategoryCard(categoryType: category)
                        .frame(width: 40)
                }
                
                
                Text(placeSearchResponseData.placeName)
                    .font(.Subtitle3_SM)
                    .foregroundStyle(.g7)
                    .lineLimit(1)
        

            }.padding(.bottom, 6)

            
            PlaceAddressText(addressText: placeSearchResponseData.roadAddress)
                
            if let activeTime = placeSearchResponseData.activeTime {
                PlaceTimeText(timeText: activeTime)
            }
            
            HStack(spacing: 12) {
                
                PlaceRatingText(rating: placeSearchResponseData.rating)
                
                reviewBtn
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
                    closeButtonTap()

                }
            }
            
        }, label: {
            Icon.close.image
                .resizable()
                .frame(width: 12, height: 12)
        })
        .padding(.top, -6)
    }
    
    /// 장소 리뷰 버튼
    private var reviewBtn: some View {
        Button(action: {
            container.navigationRouter.push(to: .placeReviewView(placeId: placeSearchResponseData.placeId))
        }, label: {
            HStack(spacing: 6) {
                Icon.review.image.fixedSize()
                
                Text("리뷰 \(placeSearchResponseData.reviewCount)개")
                    .font(.caption)
                    .foregroundStyle(.g5)
                    .lineLimit(1)
            
                
                Icon.rightChevron.image.resizable()
                    .frame(width: 4, height: 8)
            }

        })
    }
    
}

