//
//  PlaceSearchView.swift
//  Catchy
//
//  Created by LEE on 1/27/25.
//

import SwiftUI

/// 코스 DIY 생성 -> 장소 검색 화면
struct PlaceSearchView: View {
    
    @EnvironmentObject var container: DIContainer

    // MARK: - 뷰 모델
    @StateObject var viewModel: DIYCourseViewModel
        
    // MARK: - Init
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        VStack {
            if !viewModel.isPlaceListLoading {
                    
                if !viewModel.placeList.isEmpty {
                    scrollView
                } else {
                    infoView
                }
            } else {
                MainProgressComponents()
            }
                
        }
        .task {
            viewModel.getPlaceListByRegion()
        }
    }
            
    
    /// 스크롤 뷰
    /// 장소의 리스트들을 보여줌
    private var scrollView: some View {
        
        ScrollView(.vertical) {
            LazyVGrid(
                columns: [GridItem(.flexible())]
            ) {
                
                ForEach(Array(viewModel.placeList.enumerated()), id: \.element.id) { (index, place) in
                    VStack(spacing: 0) {
                        PlaceCard(place: place, reviewTap: {
                            container.navigationRouter.push(to: .placeReviewView(placeId: place.placeId))
                        })
                            .onTapGesture {
                                // TODO: - 장소 상세 화면으로 이동
                            }
                            .task {
                                if let lastPlaceId = viewModel.placeList.last?.placeId {
                                    if place.placeId >= lastPlaceId {
                                        viewModel.isPrefetching = true
                                        viewModel.getPlaceListByRegion()
                                    }
                                }
                            }
                        if index < viewModel.placeList.count - 1 {
                            Divider()
                                .padding(.vertical, 20)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 43)
            .padding(.bottom, 17)
            
        }
        .refreshable {
            await viewModel.refresh()
        }
        .onAppear {
            UIRefreshControl.appearance().tintColor = .main
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
            PlaceSearchView(container: DIContainer())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
                .environmentObject(DIContainer())
        }
    }
}


