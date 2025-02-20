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
    
    @State private var searchViewOffset: CGFloat = 0
    @State private var isSearchViewVisible: Bool = false
    
    init(contaienr: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: contaienr))
        self._appleMapViewModel = StateObject(wrappedValue: .init(placeInfoData: [], container: contaienr))
    }
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
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
        .navigationBarBackButtonHidden(true)
        .animation(.easeInOut(duration: 0.3), value: isSearchViewVisible)
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
            .padding(.top, 73)
            
            Spacer()
            
            if isSearchViewVisible {
                searchView
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .frame(alignment: .top)
        .ignoresSafeArea(.all)
    }
    
    private var searchView: some View {
        GeometryReader { proxy in
            let screenHeight = proxy.size.height
            let searchViewHeight: CGFloat = screenHeight * 0.5 // 검색 뷰 높이
            let hiddenPosition = screenHeight // 완전히 숨겨진 위치
            let visiblePosition = screenHeight - searchViewHeight // 화면 아래에 붙은 상태

            PlaceSearchView(viewModel: viewModel)
                .frame(height: searchViewHeight) // 고정된 높이 설정)
                .offset(y: isSearchViewVisible ? visiblePosition : hiddenPosition) // 화면 아래에서 시작
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
                                } else {
                                    isSearchViewVisible = false
                                }
                                searchViewOffset = 0 // 원래 위치로 복귀
                            }
                        }
                )
                .animation(.easeInOut(duration: 0.3), value: isSearchViewVisible)
        }
    }
}

struct DIYMap_Preview: PreviewProvider {
    static var previews: some View {
        DIYMap(contaienr: DIContainer())
            .environmentObject(DIContainer())
    }
}
