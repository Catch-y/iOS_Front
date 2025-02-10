//
//  PlaceDetailView.swift
//  Catchy
//
//  Created by LEE on 1/28/25.
//

import SwiftUI
import Kingfisher

struct PlaceDetailView: View {
    
    @EnvironmentObject var container: DIContainer
    
    // TODO: - 뷰 모델을 갖고 있어야함.
    // @Binding var placeList: [PlaceSearchResponse]!
    
    let place: PlaceDetailResponse
    
    @ObservedObject var viewModel: PlaceSearchViewModel
    
    var body: some View {
        VStack {
            if let place = viewModel.placeDetailResponse {
                
                PlaceInfoSection(place: place)
                
                Spacer()
                
                if !place.isVisited {
                    
                    MainBtn(text: "코스에 담기", action: {
                        
                    }, width: 370, height: 55, onoff: .on)
                    
                } else {
                    
                    MainBtn(text: "이 장소의 카테고리 선택하기", action: {
                        
                    }, width: 370, height: 55, onoff: .custom)
                }
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

