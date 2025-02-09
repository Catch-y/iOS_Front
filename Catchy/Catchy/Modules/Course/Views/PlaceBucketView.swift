//
//  PlaceBucketView.swift
//  Catchy
//
//  Created by LEE on 2/6/25.
//

import SwiftUI

struct PlaceBucketView<T: SegmentProtocol & CaseIterable>: View {
    
    /// AI 코스 생성 or DIY 코스 생성
    let courseSegmentType: T

    /// 현재 담긴 장소 리스트
    @Binding var selectedPlaceList: [PlaceDetailResponse]
    
    var body: some View {
        
        VStack(spacing: 0) {
            CustomNavigation(
                
                // TODO: - 화면 닫기 구현
                action: { print("닫기 버튼 탭") },
                title: courseSegmentType.bucketViewNavigationTitle,
                leftNaviIcon: nil,
                isShadow: true)
            
            scrollView
        }
        .ignoresSafeArea(edges: .top)
        .background(.bg1)
            
        
        
    }
    
    /// 스크롤 뷰
    /// 담은 장소 카드를 보여줌
    private var scrollView: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 1), spacing: 20, content: {
                ForEach(Array(selectedPlaceList.enumerated()), id: \.element.id) {(index, place) in
                    PlaceBucketCard(
                        placeDetailResponse: place,
                        index: index
                    ) { index in
                        self.selectedPlaceList.remove(at: index)
                    }
                }
                
            }
            )
            .padding(.top, 38)
            .safeAreaPadding(.horizontal, 16)
            .padding(.bottom, 30)
            
            // TODO: - 코스 생성하기 API 구현
            MainBtn(text: courseSegmentType.bucketViewMainBtnTitle ,
                    action: { },
                    width: 400,
                    height: 60,
                    onoff: !selectedPlaceList.isEmpty ? .custom : .off
            )
            
        }
    }
    
}

struct PlaceBucketView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(
            ["iPhone 16 Pro Max", "iPhone 11 Pro", "iPhone 12 mini"],
            id: \.self
        ) { deviceName in
            PlaceBucketView(
                courseSegmentType: CourseSegment.ai,
                selectedPlaceList: .constant(
                    [PlaceDetailResponse(
                        placeId: 1,
                        imageUrl: "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        placeName: "1",
                        placeDescription: "유러피언 요리를 아시안 스타일로 풀어내는 파인캐주얼 레스토랑",
                        categoryName: .CULTURELIFE,
                        roadAddress: "경기 남양주시 외부읍 덕소로 2번길 84",
                        activeTime: "[영업시간] 매일 09:00~22:00",
                        rating: 3,
                        isVisited: true,
                        reviewCount: 21,
                        placeSite: "www.naver.com"
                    ),
                     PlaceDetailResponse(
                        placeId: 2,
                        imageUrl: "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        placeName: "2",
                        placeDescription: "유러피언 요리를 아시안 스타일로 풀어내는 파인캐주얼 레스토랑",
                        categoryName: .CULTURELIFE,
                        roadAddress: "경기 남양주시 외부읍 덕소로 2번길 84",
                        activeTime: "[영업시간] 매일 09:00~22:00",
                        rating: 3,
                        isVisited: true,
                        reviewCount: 21,
                        placeSite: "www.naver.com"
                     ),
                     PlaceDetailResponse(
                        placeId: 3,
                        imageUrl: "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        placeName: "3",
                        placeDescription: "유러피언 요리를 아시안 스타일로 풀어내는 파인캐주얼 레스토랑",
                        categoryName: .CULTURELIFE,
                        roadAddress: "경기 남양주시 외부읍 덕소로 2번길 84",
                        activeTime: "[영업시간] 매일 09:00~22:00",
                        rating: 3,
                        isVisited: true,
                        reviewCount: 21,
                        placeSite: "www.naver.com"
                     ),
                     PlaceDetailResponse(
                        placeId: 4,
                        imageUrl: "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg",
                        placeName: "4",
                        placeDescription: "유러피언 요리를 아시안 스타일로 풀어내는 파인캐주얼 레스토랑",
                        categoryName: .CULTURELIFE,
                        roadAddress: "경기 남양주시 외부읍 덕소로 2번길 84",
                        activeTime: "[영업시간] 매일 09:00~22:00",
                        rating: 3,
                        isVisited: true,
                        reviewCount: 21,
                        placeSite: "www.naver.com"
                     ),
                    ]
                )
            )
            .previewLayout(.sizeThatFits)
            .previewDisplayName(deviceName)
        }
    }
}

