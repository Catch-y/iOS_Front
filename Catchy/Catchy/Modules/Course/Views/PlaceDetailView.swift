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
    
    // @Binding var placeList: [PlaceSearchResponse]!
    
    let place: PlaceDetailResponse
    
    var body: some View {
        VStack {
            PlaceInfoSection(place: place)
            
            
            Spacer()
            
            MainBtn(text: "코스에 담기", action: {
                
            }, width: 370, height: 55, onoff: .custom)
        }.navigationBarBackButtonHidden()
    }
    
}

