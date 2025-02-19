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
    @ObservedObject var viewModel: DIYCourseViewModel
        
    /// 현재 보고 있는 장소의 검색 데이터
    let placeSearchResponseData: PlaceSearchResponseData
    
    // MARK: - Init
    init(viewModel: DIYCourseViewModel, placeSearchResponseData: PlaceSearchResponseData) {
        self.viewModel = viewModel
        self.placeSearchResponseData = placeSearchResponseData
    }
    
    var body: some View {
        
        VStack(spacing: 36) {
            if !viewModel.isPlaceDetailLoading {
                if let place = viewModel.placeDetailResponse {
                    
                    PlaceInfoSection(place: Binding(
                        get: { place },
                        set: { viewModel.placeDetailResponse = $0 }
                    ), forDetailView: true,
                        reviewTap: {
                        container.navigationRouter.push(to: .placeReviewView(placeId: place.placeId))
                    }
                    )
                                        
                    Spacer()
                    
                    mainBtn(
                        hasCategory: place.categoryName != nil,
                        hasSelected: viewModel.selectedPlaceList.contains{ $0.placeId == placeSearchResponseData.placeId }
                    )
                    .disabled(viewModel.selectedPlaceList.contains{ $0.placeId == placeSearchResponseData.placeId } || !(viewModel.selectedPlaceList.count < 5))
                    
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
        .navigationBarBackButtonHidden(true)

    
        
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
                    viewModel.selectedPlaceList.append(placeSearchResponseData)
                },
                width: UIScreen.screenWidth - 32,
                height: 55,
                onoff: !hasSelected && viewModel.selectedPlaceList.count < 5 ? .on : .off
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
