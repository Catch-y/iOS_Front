//
//  PlaceVisitingView.swift
//  Catchy
//
//  Created by LEE on 2/10/25.
//

import SwiftUI

/// 코스 상세 정보 -> 장소 방문 뷰
struct PlaceVisitingView: View {
    
    @ObservedObject var viewModel: PlaceVisitingViewModel
    
    @Binding var placeId: Int
    
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
            
        }
        .navigationBarBackButtonHidden()
    }
}

//#Preview {
//    PlaceVisitingView()
//}
