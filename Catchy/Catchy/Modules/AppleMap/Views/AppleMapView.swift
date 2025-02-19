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
        smallMapView
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
                withAnimation {
                    container.navigationRouter.push(to: .fullScreenMap(viewModel: viewModel))
                }
            }, label: {
                Icon.zoomMap.image
                    .fixedSize()
                    .padding(.top, 13)
                    .padding(.trailing, 16)
            })
        })
    }
    
    var fullScreenMapView: some View {
        ZStack(alignment: .top, content: {
            AppleMap(viewModel: viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            CustomNavigation(action: {
                container.navigationRouter.pop()
            }, title: "코스 경로", rightNaviIcon: nil)
        })
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct AppleMapView_Preview: PreviewProvider {
    static var previews: some View {
        AppleMapView(placeInfoData: [], container: DIContainer())
            .environmentObject(DIContainer())
    }
}
