//
//  LikedPlacesView.swift
//  Catchy
//
//  Created by 권용빈 on 2/5/25.
//

import SwiftUI

/// 사용자가 좋아요한 장소를 보여주는 뷰
struct FavoritePlacesView: View {
    
    @EnvironmentObject var container: DIContainer
    
    @StateObject var viewModel: FavoritePlacesViewModel
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    // MARK: - Body
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20, content: {
            if !viewModel.isMyPlaceLoading {
                CustomNavigation(action: {
                    container.navigationRouter.pop()
                }, title: "선호 장소", rightNaviIcon: nil, isShadow: true)
                
                if !viewModel.myPlaceResponse.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible())], spacing: 40) {
                            ForEach(viewModel.myPlaceResponse, id: \.id) { place in
                                PlaceCard(place: place, reviewTap: {
                                    container.navigationRouter.push(to: .placeReviewView(placeId: place.placeId))
                                })
                                .task {
                                    if let lastPlaceId = viewModel.myPlaceResponse.last?.placeId,
                                       place.placeId == lastPlaceId {
                                        viewModel.getMyPlaceList()
                                        
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                } else {
                    CustomEmptyStateView(label: "좋아요 하신 장소가 없어요!", subLabel: "마음에 드는 장소를 담아주세요.")
                        .padding(.top, 231)
                    Spacer()
                }
            } else {
                MainProgressComponents()
            }
        })
        .ignoresSafeArea(.all)
        .task {
            viewModel.getMyPlaceList()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct FavoritePlacesView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro", "iPhone 11"], id: \.self) { deviceName in
            FavoritePlacesView(container: DIContainer())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}

