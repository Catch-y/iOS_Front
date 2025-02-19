//
//  FullScreenMap.swift
//  Catchy
//
//  Created by 정의찬 on 2/19/25.
//

import SwiftUI
import MapKit

struct FullScreenMap: View {
    
    @EnvironmentObject var container: DIContainer
    @ObservedObject var viewModel: AppleMapViewModel
    
    var body: some View {
        VStack(content: {
            
            CustomNavigation(action: {
                container.navigationRouter.pop()
            }, title: "코스 경로", rightNaviIcon: nil)
            .padding(.horizontal, 16)
            
            ZStack(alignment: .bottom, content: {
                AppleMap(viewModel: viewModel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .task {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            if let mapView = findMapView() {
                                viewModel.fitMapToRoute(in: mapView)
                                viewModel.centerMapBetweenStartAndEnd(in: mapView)

                                if viewModel.selectedPlaceId != nil {
                                    viewModel.adjustMapForSelectedAnnotation(in: mapView) // 선택된 어노테이션 위치 조정
                                }
                            }
                        }
                    }

                if let selectedPlaceId = viewModel.selectedPlaceId {
                    PlaceVisitingView(container: container, placeId: selectedPlaceId)
                        .environmentObject(container)
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                        .onAppear {
                            DispatchQueue.main.async {
                                if let mapView = findMapView() {
                                    viewModel.adjustMapForSelectedAnnotation(in: mapView) // 드래그 뷰가 나타나면 지도 중심을 위로 이동
                                }
                            }
                        }
                        .onDisappear {
                            DispatchQueue.main.async {
                                if let mapView = findMapView() {
                                    viewModel.centerMapBetweenStartAndEnd(in: mapView) // 드래그 뷰가 닫힐 때 원래 위치로 복귀
                                }
                            }
                        }
                }
            })
            .animation(.easeInOut(duration: 0.4), value: viewModel.selectedPlaceId)
        })
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 13)
        .navigationBarBackButtonHidden(true)
    }
}

struct FullScreenMap_Preview: PreviewProvider {
    static var previews: some View {
        FullScreenMap(viewModel: AppleMapViewModel(placeInfoData: [], container: DIContainer()))
            .environmentObject(DIContainer())
    }
}

extension View {
    /// 현재 화면에서 `MKMapView`를 찾아 반환하는 함수
    func findMapView() -> MKMapView? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first,
              let rootView = keyWindow.rootViewController?.view else {
            return nil
        }
        
        return rootView.subviews
            .compactMap { $0 as? MKMapView }
            .first
    }
}
