//
//  AppleMapView.swift
//  Catchy
//
//  Created by 정의찬 on 2/19/25.
//

import SwiftUI
import MapKit

struct AppleMapView: View {
    
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: AppleMapViewModel
    
    init(placeInfoData: [PlaceInfoData], container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(placeInfoData: placeInfoData, container: container))
    }
    
    var body: some View {
        ZStack {
            if viewModel.isFullScreenMap {
                Text("11")
            } else {
                smallMapView
            }
        }
        .task {
            viewModel.fetchRoute()
        }
        .overlay(content: {
            if viewModel.routerIsLoading {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    ProgressView(label: {
                        Text("경로를 불러오는 중...")
                            .font(.body3)
                            .foregroundStyle(Color.g5)
                    })
                }
            }
        })
    }
    
    var smallMapView: some View {
        
        ZStack(alignment: .topTrailing, content: {
            AppleMap(viewModel: viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Button(action: {
                viewModel.isFullScreenMap.toggle()
            }, label: {
                Icon.zoomMap.image
                    .fixedSize()
                    .padding(.top, 13)
                    .padding(.trailing, 16)
            })
        })
    }
}

struct AppleMapView_Preview: PreviewProvider {
    static var previews: some View {
        AppleMapView(placeInfoData: [], container: DIContainer())
            .environmentObject(DIContainer())
    }
}
