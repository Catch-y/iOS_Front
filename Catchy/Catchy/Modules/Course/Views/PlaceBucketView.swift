//
//  PlaceBucketView.swift
//  Catchy
//
//  Created by LEE on 2/6/25.
//

import SwiftUI

/// 담아둔 장소 뷰
struct PlaceBucketView: View {
    
    /// 현재 담긴 장소 리스트
    @Binding var selectedPlaceList: [PlaceSearchResponseData]
    
    var body: some View {
        
        VStack(spacing: 0) {
            CustomNavigation(
                
                // TODO: - 화면 닫기 구현
                action: { print("닫기 버튼 탭") },
                title: "담아둔 장소",
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
                        placeSearchResponseData: place,
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
            MainBtn(text: "코스 생성하기" ,
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
                selectedPlaceList: .constant(
                    [PlaceSearchResponseData(
                            placeId: 101,
                            placeName: "스타벅스 강남점",
                            placeImage: "https://example.com/images/starbucks.jpg",
                            category: .CAFE,
                            roadAddress: "서울특별시 강남구 테헤란로 123",
                            activeTime: "07:00 - 22:00",
                            rating: 4.5,
                            reviewCount: 120
                        ),
                        PlaceSearchResponseData(
                            placeId: 102,
                            placeName: "백다방 종로점",
                            placeImage: "https://example.com/images/baek.jpg",
                            category: .CAFE,
                            roadAddress: "서울특별시 종로구 종로1길 45",
                            activeTime: "08:00 - 21:00",
                            rating: 4.2,
                            reviewCount: 85
                        ),
                        PlaceSearchResponseData(
                            placeId: 103,
                            placeName: "한옥마을 전통찻집",
                            placeImage: "https://example.com/images/hanok.jpg",
                            category: .RESTAURANT,
                            roadAddress: "서울특별시 종로구 북촌로 12",
                            activeTime: "10:00 - 20:00",
                            rating: 4.8,
                            reviewCount: 210
                        ),
                        PlaceSearchResponseData(
                            placeId: 104,
                            placeName: "롯데월드",
                            placeImage: "https://example.com/images/lotteworld.jpg",
                            category: .CULTURELIFE,
                            roadAddress: "서울특별시 송파구 올림픽로 240",
                            activeTime: "09:00 - 22:00",
                            rating: 4.7,
                            reviewCount: 1500
                        ),
                        PlaceSearchResponseData(
                            placeId: 105,
                            placeName: "국립중앙박물관",
                            placeImage: "https://example.com/images/museum.jpg",
                            category: .EXPERIENCE,
                            roadAddress: "서울특별시 용산구 서빙고로 137",
                            activeTime: "09:30 - 18:00",
                            rating: 4.6,
                            reviewCount: 670
                        )
                     ]
                )
            )
            .previewLayout(.sizeThatFits)
            .previewDisplayName(deviceName)
        }
    }
}

