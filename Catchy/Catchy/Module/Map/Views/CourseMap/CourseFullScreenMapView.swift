//
//  CourseFullScreenMapView.swift
//  Catchy
//
//  Created by euijjang97 on 12/16/25.
//

import SwiftUI

struct CourseFullScreenMapView: View, Equatable {
    // MARK: - Property
    @State var viewModel: CourseRouteMapViewModel
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Constants
    fileprivate enum FullScreenConstants {
        static let controlButtonSize: CGFloat = 40
        static let routeInfoSpacing: CGFloat = 8
        static let topControlSpacing: CGFloat = 20
        static let mapControlBottomSpacing: CGFloat = 8
        static let bottomControlVspacing: CGFloat = 12
        static let bottomControlPadding: CGFloat = 30
    }
    
    // MARK: - Equtable
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.viewModel.places == rhs.viewModel.places
    }
    
    // MARK: - Init
    init(places: [PlaceInfo], container: DIContainer) {
        self._viewModel = State(wrappedValue: .init(places: places, container: container, locationManager: .init()))
    }
    
    // MARK: - Body
    var body: some View {
        CourseMapBaseView(viewModel: viewModel, showControl: true)
            .safeAreaBar(edge: .top, content: {
                topControlSection
            })
            .overlay(alignment: .bottomTrailing, content: {
                bottomControlSection
            })
            .loadingOverlay(isLoading: viewModel.isLoading, loadingTextType: .defaulLoading)
            .task {
                await viewModel.loadCourseRoute()
            }
            .onDisappear {
                viewModel.stopLocationUpdates()
                Task {
                    await viewModel.stopGeofence()
                }
            }
            .sheet(isPresented: $viewModel.showPlaceDetail, onDismiss: {
                viewModel.selectedPlace = nil
                    viewModel.selectedDetailPlace = nil
            }, content: {
                if let _ = viewModel.selectedPlace {
                    courseDetailSheetView
                }
            })
    }
    
    /// 상세 장소 시트 뷰
    private var courseDetailSheetView: some View {
        CourseSheetView(viewModel: viewModel)
            .background(
                GeometryReader { geo in
                    Color.clear.preference(
                        key: ContentHeightPreferenceKey.self,
                        value: geo.size.height
                    )
                }
            )
            .onPreferenceChange(ContentHeightPreferenceKey.self) { height in
                viewModel.sheetHeight = max(height, viewModel.sheetHeight)
            }
            .presentationDetents(
                [.height(20), .height(520)], selection: $viewModel.selectedDetent
            )
            .presentationDragIndicator(.visible)
            .presentationBackgroundInteraction(.enabled(upThrough: .height(viewModel.sheetHeight)))
            .interactiveDismissDisabled(true)
    }
    
    // MARK: - Top Control Section
    @ViewBuilder
    private var topControlSection: some View {
        if !viewModel.totalDistance.isEmpty {
            routeInfoBanner
                .safeAreaPadding(.horizontal, DefaultConstants.defaultSafeHorizon)
        }
    }
    
    // MARK: - BottomSection
    private var bottomControlSection: some View {
        VStack(spacing: FullScreenConstants.mapControlBottomSpacing, content: {
            /* 현재 위치 버튼 */
            mapControlButton(icon: "location.fill", action: {
                viewModel.moveCameraToCurrentLocation()
            })
            
            /* 전체 보기 */
            mapControlButton(icon: "arrow.up.left.and.arrow.down.right", action: {
                Task {
                    await viewModel.fitAllPlaces()
                }
            })
        })
        .safeAreaPadding(.horizontal, DefaultConstants.defaultSafeHorizon)
        .padding(.bottom, sheetBottomPadding)
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: sheetBottomPadding)
    }
    
    private var sheetBottomPadding: CGFloat {
        if !viewModel.showPlaceDetail {
            return 20
        }
        
        switch viewModel.selectedDetent {
        case .height(20):
            return 60
        case .height(520):
            return 530
        default:
            return 20
        }
    }
    
    private func mapControlButton(icon: String, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: icon)
                .font(.buttonText)
                .foregroundStyle(.g6)
                .frame(width: FullScreenConstants.controlButtonSize, height: FullScreenConstants.controlButtonSize)
                .glassEffect(.regular.interactive(), in: .circle)
        })
    }
    
    // MARK: - Route Info Banner
    private var routeInfoBanner: some View {
        HStack(spacing: .zero, content: {
            HStack(spacing: FullScreenConstants.routeInfoSpacing, content: {
                generateLabel(text: viewModel.totalDistance, image: "map")
                generateLabel(text: viewModel.totalDuration, image: "clock")
                generateLabel(text: viewModel.totalSteps, image: "figure.walk")
            })
            
            Spacer()
            
            if viewModel.isNavigating {
                Text("종료")
                    .font(.categoryBtn)
                    .fontWeight(.semibold)
                    .foregroundStyle(.red)
                    .padding(DefaultConstants.defaltBtnPadding)
                    .glassEffect(.regular.interactive(), in: .capsule)
                    .onTapGesture {
                        Task {
                            await viewModel.dismissSheet()
                        }
                    }
            }
        })
    }
    
    private func generateLabel(text: String, image: String) -> some View {
        Label(title: {
            Text(text)
        }, icon: {
            Image(systemName: image)
        })
        .font(.categoryBtn)
        .foregroundStyle(.white)
        .padding(DefaultConstants.defaltBtnPadding)
        .background {
            Capsule()
                .fill(.m6)
                .glassEffect(in: .capsule)
        }
    }
}

struct ContentHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - Preview Mock Data
struct PreviewData {
    static let container = DIContainer()
    
    static let places: [PlaceInfo] = [
        PlaceInfo(placeId: 1, placeName: "강남역", category: .CAFE, placeLatitude: 37.4979, placeLongitude: 127.0276, isVisited: true),
        PlaceInfo(placeId: 2, placeName: "역삼역", category: .RESTAURANT, placeLatitude: 37.5006, placeLongitude: 127.0365, isVisited: false),
        PlaceInfo(placeId: 3, placeName: "선릉역", category: .CULTURELIFE, placeLatitude: 37.5045, placeLongitude: 127.0490, isVisited: false)
    ]
}

// MARK: - Compact View Preview
#Preview("Compact Map (List Style)") {
    VStack {
        Text("코스 상세 페이지 예시")
            .font(.headline)
        
        CourseCompactMapView(
            places: PreviewData.places,
            container: PreviewData.container,
            onExpandTapped: {
                print("확장 버튼 탭됨")
            }
        )
        .equatable()
        .padding()
        
        Spacer()
    }
}

// MARK: - Full Screen View Preview
#Preview("Full Screen Map") {
    NavigationStack {
        CourseFullScreenMapView(
            places: PreviewData.places,
            container: PreviewData.container
        )
        .equatable()
        .navigationTitle("확장")
        .navigationBarTitleDisplayMode(.inline)
    }
}
