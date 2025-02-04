//
//  LikedPlacesView.swift
//  Catchy
//
//  Created by 권용빈 on 2/5/25.
//

import SwiftUI

struct FavoritePlacesView: View {
    
    @StateObject var viewModel: FavoritePlacesViewModel
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    // MARK: - Body
    var body: some View {
        
        VStack(alignment: .center, spacing: 20, content: {
            if !viewModel.isLoading {
                CustomNavigation(action: {
                    print("hello")
                }, title: "선호 장소", rightNaviIcon: nil, isShadow: true)
                
                if let data = viewModel.myPlaceResponse {
                    if !data.content.isEmpty {
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible())], spacing: 40) {
                                ForEach(data.content, id: \.placeId) { place in
                                    PlaceCard(place: place)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    } else {
                        CustomEmptyStateView(label: "좋아요 하신 장소가 없어요!", subLabel: "마음에 드는 장소를 담아주세요.")
                            .padding(.top, 231)
                    }
                } else {
                    makeProgressView()
                }
            }
        })
        .ignoresSafeArea(.all)
        .task {
            viewModel.getMyPlaceList(pageSize: 10, lastPlaceId: 1)
        }
    }
    
    private func makeProgressView() -> some View {
        VStack(alignment: .center) {
            Spacer()
            
            ProgressView()
                .controlSize(.regular)
            
            Spacer()
        }
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

