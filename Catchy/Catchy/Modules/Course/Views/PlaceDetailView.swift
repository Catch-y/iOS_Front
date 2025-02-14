////
////  PlaceDetailView.swift
////  Catchy
///
//  Created by LEE on 1/28/25.
//

import SwiftUI
import Kingfisher

/// 장소 검색 - > 장소 상세 정보
struct PlaceDetailView: View {
    
    @EnvironmentObject var container: DIContainer
        
    @ObservedObject var viewModel: PlaceSearchViewModel
    
    var body: some View {
        VStack {
            if let place = viewModel.placeDetailResponse {
        
                PlaceInfoSection(place: Binding(
                    get: { place },
                    set: { viewModel.placeDetailResponse = $0 }
                ))
                
                MainBtn(
                    text: "이 장소의 카테고리 선택하기",
                    action: {
                    },
                    width: 400,
                    height: 55,
                    onoff: .on
                )
                .safeAreaPadding(.horizontal, 16)
                
                Spacer()
                
            } else {
                ProgressView()
            }
            
        }
        .task {
            
            if let placeId = viewModel.placeDetailResponse?.placeId {
                viewModel.getPlaceDetail(placeId: placeId)
            }
        }
        .navigationBarBackButtonHidden()

    }
    
}

