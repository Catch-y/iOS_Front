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
    @Binding var isBucketViewPresented: Bool
        
    init(selectedPlaceList: Binding<[PlaceSearchResponseData]>, isBucketViewPresented: Binding<Bool>) {
        self._selectedPlaceList = selectedPlaceList
        self._isBucketViewPresented = isBucketViewPresented
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            CustomNavigation(
                
                action: {
                    isBucketViewPresented.toggle()
                },
                title: "담아둔 장소",
                leftNaviIcon: nil,
                isShadow: true
            )
            if selectedPlaceList.isEmpty {
                infoView
                Spacer()

            } else {
                scrollView

            }
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
                        index: index,
                        canDelete: true
                    ) {
                        self.selectedPlaceList.remove(at: index)
                    }.environmentObject(container)
                }
                
            }
            )
            .padding(.top, 38)
            .safeAreaPadding(.horizontal, 16)
            .padding(.bottom, 30)
            
            MainBtn(text: "코스 생성하기" ,
                    action: {
                container.navigationRouter.push(to: .diyCourseCreateView(placeIds: Array(selectedPlaceList.map(\.self.placeId))))
            },
                    width: UIScreen.screenWidth - 32,
                    height: 60,
                    onoff: !selectedPlaceList.isEmpty ? .custom : .off
            )
            .disabled(selectedPlaceList.isEmpty)
            
        }
    }
    
    /// 담은 장소가 없을 때 뷰
    private var infoView : some View {
        VStack(spacing: 9){
            Icon.smileSearch.image
                .fixedSize()
                .padding(.bottom, 6)
            Text("담아둔 장소가 없어요!")
                .font(.Subtitle2)
                .foregroundStyle(.g7)
            Text("마음에 드는 장소를 담아보세요.")
                .font(.Body1_2)
                .foregroundStyle(.g4)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(edges: .all)
        
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
            ]), isBucketViewPresented: .constant(true))
            .environmentObject(DIContainer())
        }
    }
}

