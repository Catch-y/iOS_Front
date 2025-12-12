//
//  RecommendPlaceCard.swift
//  Catchy
//
//  Created by Apple Coding machine on 11/25/25.
//


import SwiftUI

struct RecommendPlaceCard: View, Equatable {
    @EnvironmentObject var container: DIContainer
    @Binding var data: PlaceRecommendContentDTO
    let action: () -> Void // 장소 좋아요를 위한 Action
    
    // MARK: - Equatable
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.data.id == rhs.data.id
    }
    
    // MARK: - Constant
    fileprivate enum RecommendPlaceConstants {
        static let imageHeight: CGFloat = 103
        static let titleTagSpacing: CGFloat = 8
        static let labelSpacing: CGFloat = 1
        static let rightPlaceSpacing: CGFloat = 7
        static let rightInfoSpacing: CGFloat = 10
        static let rightPlaceBottomSpacing: CGFloat = 3
    }
    
    // MARK: - Init
    init(data: Binding<PlaceRecommendContentDTO>, action: @escaping () -> Void) {
        self._data = data
        self.action = action
    }
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .top) {
            leftPlace
            rightInfo
        }
    }
    
    // MARK: - Left
    private var leftImage: some View {
        RemoteImage(urlString: data.placeImage, size: .init(width: getScreenSize().width * 0.4, height: RecommendPlaceConstants.imageHeight), ratio: 168/103)
    }
    
    private var leftPlace: some View {
        ZStack(alignment: .topLeading, content: {
            leftImage
            LikeButton(data: $data, action: action, style: .withCircle())
                .offset(x: 8, y: 6)
        })
    }
    
    // MARK: - Right
    /// 오른쪽 장소 정보
    private var rightInfo: some View {
        VStack(alignment: .leading, spacing: RecommendPlaceConstants.rightPlaceSpacing, content: {
            rightPlaceTop
            rightPlaceBottom
        })
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    /// 오른쪽 장소 이름 및 포인트
    private var rightPlaceTop: some View {
        VStack(alignment: .leading, spacing: RecommendPlaceConstants.rightPlaceSpacing, content: {
            rightPlaceTitle
            rightPlacePoint
        })
    }
    
    /// 오른쪽 장소 이름
    private var rightPlaceTitle: some View {
        HStack(content: {
            PlaceTitleTagView(placeName: data.placeName)
            Spacer()
            PlaceCategoryTag(category: data.category)
        })
    }
    
    /// 오른쪽 장소 포인트
    private var rightPlacePoint: some View {
        HStack(spacing: RecommendPlaceConstants.rightPlaceSpacing, content: {
            RatingPoint(point: "\(data.rating)")
            ReviewPoint(point: "\(data.reviewCount)", id: data.placeId)
        })
    }
    
    /// 오른쪽 장소 및 운영시간 안내
    private var rightPlaceBottom: some View {
        VStack(alignment: .leading, spacing: RecommendPlaceConstants.rightPlaceBottomSpacing, content: {
            PlaceLabel(image: Image(.location), text: data.roadAddress, labelSpacing: RecommendPlaceConstants.labelSpacing)
            
            if let time = data.activeTime, !time.isEmpty {
                PlaceLabel(image: Image(.time), text: time, labelSpacing: RecommendPlaceConstants.labelSpacing)
            }
        })
    }
}

#Preview {
    RecommendPlaceCard(
        data: .constant(.init(
            placeId: 1,
            placeName: "심퍼티쿠시 용산점",
            placeImage: "https://i.namu.wiki/i/dYB5Cd-rFWKdv9ywxqQMj8wI0lz7KYGt7iwNVw8hfl6yUHXrIx6J0Ra4WCyIBNuHkad7yr0s3M41a7OzoIhbql5fiQqpuvMVpWtuE5Zx-okPTyCIMnhkfRc5UOQtnRr39iQCGaYbMukt_dgfKzoJEw.webp",
            category: "이탈리안 퓨전",
            roadAddress: "서울 용산구 한강대로52길 17-3",
            activeTime: "11:00 - 22:00",
            rating: 4.6,
            placeLatitude: 37.5313,
            placeLongitude: 126.9705,
            reviewCount: 842,
            liked: true
        )),
        action: {
            print("카드 탭 액션 실행")
        }
    )
}
