//
//  PlaceDetailView.swift
//  Catchy
//
//  Created by LEE on 1/28/25.
//

import SwiftUI
import Kingfisher

/// 코스 DIY 생성 -> 장소 검섹 - > 장소 상세 화면
struct PlaceDetailView: View {
            
    @EnvironmentObject var container: DIContainer

    // MARK: - 뷰 모델
    @StateObject var viewModel: PlaceDetailViewModel

    // MARK: - 장소 상세 화면 Properties
    /// 장소 검색 화면에서 현재 사용자가 담은 장소의 리스트
    @Binding var selectedPlaceList: [PlaceSearchResponseData]
    
    /// 현재 보고 있는 장소의 데이터 (현재 뷰에서 데이터 보여줄 때 사용 X)
    @Binding var placeSearchResponseData: PlaceSearchResponseData

    // MARK: - Init
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
                        container.navigationRouter.push(to: .placeReviewRegisterView(placeId: place.placeId))
                    }
                    )
                    
                    mainBtn(
                        hasCategory: place.categoryName != nil,
                        hasSelected: selectedPlaceList.contains{ $0.placeId == placeSearchResponseData.placeId }
                    )
                    .disabled((place.categoryName != nil) && !selectedPlaceList.contains{ $0.placeId == placeSearchResponseData.placeId} && (selectedPlaceList.count < 5))
                    
                    Spacer()
                    
                }
            } else {
                MainProgressComponents()
            }
            
        }
        .task {
            viewModel.getPlaceDetail(placeId: placeSearchResponseData.placeId)
        }
        .fullScreenCover(isPresented: $viewModel.isCategoryViewPresented, onDismiss: {
            viewModel.getPlaceDetail(placeId: placeSearchResponseData.placeId)
        }) {

            CategoryRegisterView(placeId: placeSearchResponseData.placeId, container: container, isPresented: $viewModel.isCategoryViewPresented)
            
        }
        .navigationBarBackButtonHidden()
        
    }
    
    /// 현재 장소의 데이터에 따라 버튼 생성
    /// - Parameters:
    ///   - hasCategory: 해당 장소의 카테고리가 있는가
    ///   - hasSelected: 현재 장소를 사용자가 담았는가
    /// - Returns: 버튼 리턴
    private func mainBtn(hasCategory: Bool, hasSelected: Bool) -> some View {
        
        if hasCategory {
            
            MainBtn(
                text: hasSelected ? "이미 담은 장소입니다." : "코스에 담기",
                action: {
                    selectedPlaceList.append(placeSearchResponseData)
                    // TODO: - 이전 화면으로 이동
                },
                width: UIScreen.screenWidth - 32,
                height: 55,
                onoff: !hasSelected && selectedPlaceList.count < 5 ? .on : .off
            )

            
        } else {
            MainBtn(
                text: "이 장소의 카테고리 선택하기",
                action: {
                    viewModel.showCategoryView()
                },
                width: UIScreen.screenWidth - 32,
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
