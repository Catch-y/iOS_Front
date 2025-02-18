//
//  PlaceInfoSection.swift
//  Catchy
//
//  Created by LEE on 1/28/25.
//

import SwiftUI
import Kingfisher

struct PlaceInfoSection: View {
    
    // MARK: - Properties
    /// 장소 상세 정보 데이터
    @Binding var place: PlaceDetailResponse
    
    /// 좋아요 누를 때 액션
    /// nil인 경우 좋아요 못 누름
    let likeTap: (() -> Void)?
    
    /// 리뷰 탭 액션
    let reviewTap: () -> Void
    
    // MARK: - Init
    init(place: Binding<PlaceDetailResponse>, likeTap: (() -> Void)? = nil, reviewTap: @escaping () -> Void) {
        self._place = place
        self.likeTap = likeTap
        self.reviewTap = reviewTap
    }
    
    var body: some View {
        VStack(spacing: 19) {
            if let url = URL(string: DataFormatter.shared.formattedImageUrl(placeImageURL: place.imageUrl)) {
                KFImage(url)
                    .placeholder{
                        ProgressView()
                            .controlSize(.large)
                    }
                    .retry(maxCount: 2, interval: .seconds(2))
                    .downsampling(size: CGSize(width: UIScreen.screenWidth, height: 103))
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
                
                if let category = place.categoryName {
                    CategoryCard(categoryType: category)
                        .frame(width: 60)
                }
                
                Spacer()
                
                if likeTap != nil {
                    LikeButton(data: $place, action: likeTap!, forPlace: true)
                    
                }
                
            }
            .padding(.bottom, 8)
            
            Text(place.placeDescription)
                .font(.body3)
                .foregroundStyle(.g4)
                

            HStack(spacing: 12) {
                
                PlaceRatingText(rating: place.rating)
                
                reviewButton
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

