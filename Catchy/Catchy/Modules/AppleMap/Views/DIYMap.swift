//
//  DIYMap.swift
//  Catchy
//
//  Created by 정의찬 on 2/20/25.
//

import SwiftUI
import MapKit

struct DIYMap: View {
    
    @EnvironmentObject var container: DIContainer
    
    @StateObject var viewModel: DIYCourseViewModel
    @StateObject var appleMapViewModel: AppleMapViewModel
    @StateObject var locationManager = BaseLocationManager.shared
    
    @State private var searchViewOffset: CGFloat = 0
    @State private var isSearchViewVisible: Bool = false
    @State private var selectedPlace: PlaceSearchResponseData?
    @State private var isPlaceDetailPresented: Bool = false
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
        self._appleMapViewModel = StateObject(wrappedValue: .init(placeInfoData: [], container: container))
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AppleMap(viewModel: appleMapViewModel)
                .onAppear {
                    locationManager.getCurrentUserLocation { location in
                        if let userLocation = location {
                            appleMapViewModel.setUserLocation(userLocation)
                        }
                    }
                }
                .ignoresSafeArea(.all)
            
            VStack {
                topController
                Spacer()
            }

            if isSearchViewVisible {
                searchView
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(1)
            }
        }
        .navigationBarBackButtonHidden(true)
        .animation(.easeInOut(duration: 0.3), value: isSearchViewVisible)
        .sheet(isPresented: $isPlaceDetailPresented) {
            if let place = selectedPlace {
                PlaceDetailView(viewModel: viewModel, placeSearchResponseData: place)
                    .presentationDetents([.fraction(0.75)])
                    .presentationCornerRadius(20)
            }
        }
    }
    
    private var topController: some View {
        VStack {
            HStack(spacing: 16) {
                Button(action: {
                    container.navigationRouter.pop()
                }, label: {
                    Icon.leftChevron.image
                        .fixedSize()
                })
                
                CustomTextField(text: $viewModel.searchText, searchTextField: .mapView)
                    .onSubmit {
                        viewModel.getPlaceListByRegion()
                        withAnimation {
                            isSearchViewVisible = true
                        }
                    }
                    .s2t()
            }
            .padding(.horizontal, 16)
            .padding(.top, 13)
        }
    }
    
    
    private var searchView: some View {
        GeometryReader { proxy in
            let screenHeight = proxy.size.height
            let searchViewHeight: CGFloat = screenHeight * 0.5
            let hiddenPosition = screenHeight
            let visiblePosition = screenHeight - searchViewHeight
            
            PlaceSearchView(onPlaceSelected: { place in
                withAnimation {
                    selectedPlace = place
                    isPlaceDetailPresented = true
                    isSearchViewVisible = false
                }
            }, viewModel: viewModel)
            .frame(height: searchViewHeight)
            .offset(y: isSearchViewVisible ? visiblePosition : hiddenPosition)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let newOffset = value.translation.height
                        if newOffset < 0 {
                            searchViewOffset = max(newOffset, -searchViewHeight)
                        }
                    }
                    .onEnded { value in
                        withAnimation {
                            if value.translation.height < -50 {
                                isSearchViewVisible = true
                            }
                            searchViewOffset = 0
                        }
                    }
            )
        }
    }
}

struct DIYMap_Preview: PreviewProvider {
    static var previews: some View {
        DIYMap(container: DIContainer())
            .environmentObject(DIContainer())
    }
}
