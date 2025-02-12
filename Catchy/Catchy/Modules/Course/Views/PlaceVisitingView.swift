//
//  PlaceVisitingView.swift
//  Catchy
//
//  Created by LEE on 2/10/25.
//

import SwiftUI

/// 코스 상세 정보 -> 장소 방문 뷰
struct PlaceVisitingView: View {
    
    @StateObject var viewModel: PlaceVisitingViewModel
    
    @Binding var placeId: Int
        
    init(container: DIContainer, placeId: Binding<Int>) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
        self._placeId = placeId
    }

    var body: some View {
        
        VStack {
            if let place = viewModel.placeDetailResponse {
                
                PlaceInfoSection(place: place)
                
                
                
                MainBtn(text: "길 찾기", action: {}, width: 370, height: 55, onoff: .on)
                
            } else {
                ProgressView()
            }
            
        }
        .task {
            viewModel.getPlaceDetail(placeId: placeId)
        }
        .navigationBarBackButtonHidden()
    }
}

struct PlaceVisitingView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(
            ["iPhone 16 Pro Max", "iPhone 11"],
            id: \.self
        ) { deviceName in
            PlaceVisitingView(container: DIContainer(), placeId: .constant(1))
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
                .environmentObject(DIContainer())
        }
    }
}


