//
//  SearchRecommendCard.swift
//  Catchy
//
//  Created by euijjang97 on 12/6/25.
//

import SwiftUI

struct SearchRecommendCard: View {
    
    // MARK:  - Property
    let data: PlaceSearchContent.PlaceInfoResponse
    
    fileprivate enum SearchRecommendConstants {
        static let placeHeight: CGFloat = 116
        static let placeInfoSpacing: CGFloat = 6
        static let labelSpacing: CGFloat = 5
        static let placePointSpacing: CGFloat = 12
        static let placeLabelSpacing: CGFloat = 1
        static let placeVstackSpacing: CGFloat = 12
    }
    
    // MARK: - Init
    init(data: PlaceSearchContent.PlaceInfoResponse) {
        self.data = data
    }
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .top, content: {
            placeImage
            placeInfoGroup
        })
    }
    
    // MARK: - Left
    /// 장소 이미지
    private var placeImage: some View {
        RemoteImage(urlString: data.imageUrl, size: .init(width: getScreenSize().width * 0.4, height: SearchRecommendConstants.placeHeight))
    }
    
    // MARK: - Right
    /// 오른쪽 장소 정보 그룹
    private var placeInfoGroup: some View {
        VStack(alignment: .leading, spacing: SearchRecommendConstants.placeInfoSpacing, content: {
            rightPlaceTitle
            rightPlaceInfo
            Spacer()
            rightPlacePoint
        })
    }
    /// 오른쪽 장소 타이틀
    private var rightPlaceTitle: some View {
        HStack(content: {
            PlaceTitleTagView(placeName: data.placeName)
            PlaceCategoryTag(category: data.categoryName.rawValue, fontColor: .white, color: data.categoryName.categoryBgColor)
        })
    }
    
    /// 오른쪽 장소 및 운영시간 안내
    private var rightPlaceInfo: some View {
        VStack(alignment: .leading, spacing: SearchRecommendConstants.placeInfoSpacing, content: {
            PlaceLabel(image: Image(.location), text: data.roadAddress, labelSpacing: SearchRecommendConstants.labelSpacing)
            
            if let time = data.activeTime, !time.isEmpty {
                PlaceLabel(image: Image(.time), text: time, labelSpacing: SearchRecommendConstants.labelSpacing)
            }
        })
    }
    
    /// 오른쪽 장소 포인트
    private var rightPlacePoint: some View {
        HStack(spacing: SearchRecommendConstants.placePointSpacing, content: {
            PlaceLabel(image: Image(.star), text: "평점 \(data.rating)", labelSpacing: SearchRecommendConstants.placeLabelSpacing)
            PlaceLabel(image: Image(.review), text: "리뷰 \(data.reviewCount)개", labelSpacing: SearchRecommendConstants.labelSpacing)
        })
        .offset(y: -10)
    }
}

#Preview {
    SearchRecommendCard(data: .init(placeId: 0, imageUrl: "https://i.namu.wiki/i/Gc-iRxDS_rz8040Rpoin7pvpuEhXgYCWFqwKNXMqb-xz322o0PllwsnjeC3yjgSo8sjaxBtTbUuw5xDfp2_r72x5GtuW9rTtFaR30zVAi4UlnblRfoJ2XEBQyPfEZbtEn2LqUZZPdEsFu5nQICjxAg.webp", placeName: "경복궁", categoryName: .CULTURELIFE, roadAddress: "서울시 용산구 한강대로52길 17-3 1F", activeTime: "월-금 · 16:00 - 21:00", rating: 4.3, reviewCount: 203))
}
