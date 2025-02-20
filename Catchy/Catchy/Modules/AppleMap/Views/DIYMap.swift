//
//  DIYMap.swift
//  Catchy
//
//  Created by 정의찬 on 2/20/25.
//

import SwiftUI

struct DIYMap: View {
    
    @EnvironmentObject var container: DIContainer
    
    @StateObject var viewModel: DIYCourseViewModel
    @StateObject var appleMapViewModel: AppleMapViewModel
    @StateObject var locationManager = BaseLocationManager.shared
    
    init(contaienr: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: contaienr))
        self._appleMapViewModel = StateObject(wrappedValue: .init(placeInfoData: [], container: contaienr))
    }
    
    var body: some View {
        ZStack(alignment: .top, content: {
            AppleMap(viewModel: appleMapViewModel)
                .onAppear {
                    locationManager.getCurrentUserLocation { location in
                        if let userLocation = location {
                            appleMapViewModel.setUserLocation(userLocation)
                        }
                    }
                }
                .ignoresSafeArea(.all)
            
            topController
                
        })
        
    }
    
    private var topController: some View {
        VStack(content: {
            HStack(spacing: 16, content: {
                
                Button(action: {
                    container.navigationRouter.pop()
                }, label: {
                    Icon.leftChevron.image
                        .fixedSize()
                })
                
                CustomTextField(text: $viewModel.searchText, searchTextField: .mapView)
                    .onSubmit {
                        viewModel.getPlaceListByRegion()
                    }
                    .s2t()
            })
            .padding(.horizontal, 16)
            
            Spacer()
            
            if !viewModel.placeList.isEmpty {
                PlaceSearchView(viewModel: viewModel)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        })
        .frame(alignment: .top)
    }
}

struct DIYMap_Preview: PreviewProvider {
    static var previews: some View {
        DIYMap(contaienr: DIContainer())
            .environmentObject(DIContainer())
    }
}
