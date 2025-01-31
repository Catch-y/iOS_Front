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
    
    var body: some View {
        VStack {
            PlaceInfoSection(place: place)
            
            
            Spacer()
            
            /// 방문하지 않은 경우.
            /// 해당 장소에 대한 카테고리를 선택해야함.
            if !place.isVisited{
                
                // TODO: - 장소 카테고리 선택 API 구현
                MainBtn(text: "코스에 담기", action: {
                    
                }, width: 370, height: 55, onoff: .custom)
                
            
                
            } else {    /// 방문한 경우
                
                // TODO: - 장소를 넣는 API 구현
                
            }
            
        }.navigationBarBackButtonHidden()
    }
    
}

