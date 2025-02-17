//
//  PlaceBucketView.swift
//  Catchy
//
//  Created by LEE on 2/6/25.
//

import SwiftUI

/// 담아둔 장소 화면
struct PlaceBucketView: View {
        
    @EnvironmentObject var container: DIContainer
    
    // MARK: - 담아둔 장소 화면 Properties
    /// 현재 담긴 장소 리스트
    @Binding var selectedPlaceList: [PlaceSearchResponseData]
    
    /// 담아둔 장소 화면 상태
    @Binding var isPresented: Bool
    
    // MARK: - 코스 생성하기 화면 Properties
    /// 코스 생성하기 뷰 상태
    @State var isCreateViewPresented: Bool = false
    
    init(selectedPlaceList: Binding<[PlaceSearchResponseData]>, isPresented: Binding<Bool>) {
        self._selectedPlaceList = selectedPlaceList
        self._isPresented = isPresented
    }
    
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
        .fullScreenCover(isPresented: $isCreateViewPresented, onDismiss: {
            isPresented.toggle()
        }) {
            DIYCourseCreateView(container: container, placeIds: Array(selectedPlaceList.map(\.self.placeId)), isPresented: $isCreateViewPresented)
        }
            
        
        
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
                    action: {
                isCreateViewPresented.toggle()
            },
                    width: UIScreen.screenWidth - 32,
                    height: 60,
                    onoff: !selectedPlaceList.isEmpty ? .custom : .off
            )
            .disabled(selectedPlaceList.isEmpty)
            
        }
    }
    
}


struct PlaceBucketView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(
            ["iPhone 16 Pro Max", "iPhone 11"],
            id: \.self
        ) { deviceName in
            PlaceBucketView(selectedPlaceList: .constant([
                PlaceSearchResponseData(
                            placeId: 1,
                            placeName: "스타벅스 강남점",
                            placeImage: "https://example.com/starbucks.jpg",
                            category: .CAFE,
                            roadAddress: "서울특별시 강남구 테헤란로 123",
                            activeTime: "08:00 - 22:00",
                            rating: 4.5,
                            reviewCount: 120,
                            liked: true
                        ),
                        PlaceSearchResponseData(
                            placeId: 2,
                            placeName: "이태원 맛집",
                            placeImage: "https://example.com/restaurant.jpg",
                            category: .RESTAURANT,
                            roadAddress: "서울특별시 용산구 이태원로 45",
                            activeTime: "11:00 - 23:00",
                            rating: 4.8,
                            reviewCount: 340,
                            liked: false
                        ),
                        PlaceSearchResponseData(
                            placeId: 3,
                            placeName: "N서울타워",
                            placeImage: "https://example.com/nseoultower.jpg",
                            category: .EXPERIENCE,
                            roadAddress: "서울특별시 용산구 남산공원길 105",
                            activeTime: "09:00 - 22:00",
                            rating: 4.7,
                            reviewCount: 980,
                            liked: true
                        )
            ]), isPresented: .constant(true))
            .environmentObject(DIContainer())
        }
    }
}

