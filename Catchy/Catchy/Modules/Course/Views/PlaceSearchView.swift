//
//  PlaceSearchView.swift
//  Catchy
//
//  Created by LEE on 1/27/25.
//

import SwiftUI

struct PlaceView: View {
    
    @StateObject var viewModel: PlaceSearchViewModel
    
    @EnvironmentObject var container: DIContainer
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        NavigationStack(path: $container.navigationRouter.destination) {
            VStack {
                if !viewModel.isPlaceListLoading { /// 데이터 요청 완료
                    
                    if let data = viewModel.placeSearchResponse {
                        if data.placeInfoPreviews.isEmpty { /// 데이터가 0개인 경우
                            infoView
                        } else {
                            scrollView
                        }
                    }
                } else { /// 데이터 요청 중
                    Spacer ()
                    
                    ProgressView()
                    
                    Spacer()
                }
                
            }
            .task {
                viewModel
                    .getPlaceList(
                        placeSearchRequest: .init(
                            searchKeyword: "",
                            page: 0
                        )
                    )
            }
            
        }.navigationDestination(
            for: NavigationDestination.self
        ) { destination in
            NavigationRoutingView(destination: destination)
                .environmentObject(container)
        }
    }
    
    /// 스크롤 뷰
    /// 장소의 리스트들을 보여줌
    private var scrollView: some View {
        
        ScrollView(.vertical) {
            LazyVGrid(
                columns: [GridItem(.flexible())]
            ) {
                if let content = viewModel.placeSearchResponse?.placeInfoPreviews {
                    ForEach(
                        Array(content.enumerated()),
                        id: \.1.id
                    ) {
                        index,
                        place in
                        VStack(spacing: 0) {
                            PlaceCard(place: place).onTapGesture{
                                Task{
                                    await viewModel
                                        .getPlaceDetail(
                                            placeId: place.placeId
                                        )
                                        
                                    if let placeData = viewModel.placeDetailResponse {
                                            
                                        container.navigationRouter.push(
                                            to: .PlaceDetailView(
                                                placeDetailResponse: placeData
                                            )
                                        )
                                    }
                                }
                                    
                            }
                                
                            if index < content.count - 1 {
                                Divider()
                                    .padding(.vertical, 20)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 43)
            .padding(.bottom, 17)
            
            
        }
    }
                   
    /// 검색 결과가 없을 떄의 뷰
    private var infoView : some View {
        VStack(spacing: 9){
            Icon.smileSearch.image
                .fixedSize()
                .padding(.bottom, 6)
            Text("검색어와 일치하는 내용이 없어요!")
                .font(.Subtitle2)
                .foregroundStyle(.g7)
            Text("확인 후 다시 검색해주세요.")
                .font(.Body1_2)
                .foregroundStyle(.g4)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(edges: .all)
        
    }
    
}

struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(
            ["iPhone 16 Pro Max", "iPhone 11"],
            id: \.self
        ) { deviceName in
            PlaceView(container: DIContainer())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
                .environmentObject(DIContainer())
        }
    }
}


