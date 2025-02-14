//
//  PlaceDetailView.swift
//  Catchy
//
//  Created by LEE on 1/28/25.
//

import SwiftUI
import Kingfisher

/// 장소 검색 - > 장소 상세 정보
struct PlaceDetailView: View {
            
    @EnvironmentObject var container: DIContainer

    @StateObject var viewModel: PlaceDetailViewModel

    /// 장소 검색 화면에서 현재 사용자가 담은 장소의 리스트
    @Binding var selectedPlaceList: [PlaceSearchResponseData]
    
    /// 현재 보고 있는 장소의 데이터 (현재 뷰에서 데이터 보여줄 때 사용 X)
    @Binding var placeSearchResponseData: PlaceSearchResponseData

    init(selectedPlaceList: Binding<[PlaceSearchResponseData]>, container: DIContainer, placeSearchResponseData: Binding<PlaceSearchResponseData>) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
        self._selectedPlaceList = selectedPlaceList
        self._placeSearchResponseData = placeSearchResponseData
    }
    
    var body: some View {
        
        VStack(spacing: 36) {
            if !viewModel.isLoading {
                if let place = viewModel.placeDetailResponse {
            
                    PlaceInfoSection(place: Binding(
                        get: { place },
                        set: { viewModel.placeDetailResponse = $0 }
                    ), reviewTap: {
                        // TODO: - 리뷰 보는 화면으로 이동
                    }
                    )
                
                    mainBtn(hasCategory: place.categoryName.rawValue != "", hasSelected: selectedPlaceList.contains{ $0.placeId == placeSearchResponseData.placeId})
                    
                    Spacer()
                    
                }
            } else {
                MainProgressComponents()
            }
            
        }
        .task {
            viewModel.getPlaceDetail(placeId: placeSearchResponseData.placeId)
        }
        .fullScreenCover(isPresented: $viewModel.isPresented, onDismiss: {
            viewModel.getPlaceDetail(placeId: placeSearchResponseData.placeId)
        }) {
        
            CategoryRegisterView(placeSearchResponseData: $placeSearchResponseData, container: container, isPresented: $viewModel.isPresented)
            
        }
        .navigationBarBackButtonHidden()
        
    }
    
    private func mainBtn(hasCategory: Bool, hasSelected: Bool) -> some View {
        
        if hasCategory {
            MainBtn(
                text: "코스에 담기",
                action: {
                    selectedPlaceList.append(placeSearchResponseData)
                    // TODO: - 이전화면으로 이동
                },
                width: 400,
                height: 55,
                onoff: hasSelected || (selectedPlaceList.count > 4) ? .off : .on
            )
        } else {
            MainBtn(
                text: "이 장소의 카테고리 선택하기",
                action: {
                    print(viewModel.isPresented)
                    viewModel.isPresented = true
                    print(viewModel.isPresented)

                },
                width: 400,
                height: 55,
                onoff: .custom
            )
        }
        
    }
    
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(
            ["iPhone 16 Pro Max", "iPhone 11"],
            id: \.self
        ) { deviceName in
            PlaceDetailView(selectedPlaceList: .constant([]), container: DIContainer(), placeSearchResponseData: .constant(.init(placeId: 1, placeName: "심퍼티쿠시 용산점", placeImage: "https://m.segyebiz.com/content/image/2023/11/10/20231110510421.jpg", category: .BAR, roadAddress: "경기 남양주시 와부읍 덕소로2번길 84", activeTime: "[영업시간] 매일 09:00 ~ 22:00", rating: 4.1, reviewCount: 32, liked: false)))
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
                .environmentObject(DIContainer())
        }
    }
}
