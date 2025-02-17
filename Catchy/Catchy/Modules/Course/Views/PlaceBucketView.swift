//
//  PlaceBucketView.swift
//  Catchy
//
//  Created by LEE on 2/6/25.
//

import SwiftUI

/// 담아둔 장소 화면
struct PlaceBucketView: View {
    
    // MARK: - 담아둔 장소 화면 Properties
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
                    width: UIScreen.screenWidth,
                    height: 60,
                    onoff: !selectedPlaceList.isEmpty ? .custom : .off
            )
            
        }
    }
    
}
