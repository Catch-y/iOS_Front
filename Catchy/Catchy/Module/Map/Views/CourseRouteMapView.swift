//
//  CourseRouteMapView.swift
//  Catchy
//
//  Created by euijjang97 on 12/15/25.
//

import SwiftUI
import MapKit

struct CourseRouteMapView: View {
    // MARK: - Property
    @State var viewModel: CourseRouteMapViewModel
    let isCompact: Bool
    var onExpandTapped: ( ()->Void )?
    
    // MARK: - Constants
    fileprivate enum MapConstants {
        static let compactHeight: CGFloat = 240
        static let routeLineWidth: CGFloat = 3
        static let navigationRouteLineWidth: CGFloat = 6
        static let expandButtonSize: CGFloat = 32
        static let controlButtonSize: CGFloat = 40
        static let routeInfoSpacing: CGFloat = 16
        static let transportPickerSpacing: CGFloat = 30
        static let topControlSpacing: CGFloat = 20
        static let mapControlBottomSpacing: CGFloat = 8
        static let bottomControlVspacing: CGFloat = 12
    }
    
    // MARK: - Init
    init(
        places: [PlaceInfo],
        isCompact: Bool = true,
        locationManager: LocationManager = .init(),
        onExpandTapped: (() -> Void)? = nil
    ) {
        self._viewModel = State(wrappedValue: .init(places: places, locationManager: locationManager)
        )
        self.isCompact = isCompact
        self.onExpandTapped = onExpandTapped
    }
    
    // MARK: - Body
    var body: some View {
        Group {
            if isCompact {
                compactMapView
            } else {
                fullScreenMapView
            }
        }
        .task {
            await viewModel.loadCourseRoute()
        }
        .onDisappear {
            viewModel.stopLocationUpdates()
        }
    }
    
    // MARK: - Map Content
    private var mapContent: some View {
        Map(position: $viewModel.cameraPosition, content: {
            routePolylines
            placemarkers
            
            if viewModel.isNavigating {
                UserAnnotation()
            }
        })
        .mapStyle(.standard)
        .mapControls {
            if !isCompact {
                MapCompass()
                MapScaleView()
            }
        }
    }
    
    @MapContentBuilder
     var routePolylines: some MapContent {
         if viewModel.isNavigating, let navRoute = viewModel.navigationRoute {
             MapPolyline(navRoute.polyline)
                 .stroke(.blue, style: StrokeStyle(
                     lineWidth: MapConstants.navigationRouteLineWidth,
                     lineCap: .round,
                     lineJoin: .round
                 ))
         } else if let fullRoute = viewModel.fullCourseRoute {
             // 전체 경로를 하나로 그리기
             MapPolyline(fullRoute.polyline)
                 .stroke(
                     .main,
                     style: StrokeStyle(
                         lineWidth: MapConstants.routeLineWidth,
                         lineCap: .round,
                         lineJoin: .round
                     )
                 )
         }
     }
    
    @MapContentBuilder
    private var placemarkers: some MapContent {
        ForEach(Array(viewModel.places.enumerated()), id: \.element.id) { index, place in
            Annotation(place.placeName, coordinate: .init(latitude: place.placeLatitude, longitude: place.placeLongitude), anchor: .bottom, content: {
                CourseMarkerView(place: place, index: index, isSelected: viewModel.selectedPlace?.id == place.id)
                    .onTapGesture {
                        viewModel.selectPlace(place)
                    }
            })
        }
    }
    
    // MARK: - Compact Map View
    private var compactMapView: some View {
        ZStack(alignment: .topTrailing, content: {
            mapContent
                .frame(height: MapConstants.compactHeight)
                .clipShape(RoundedRectangle(cornerRadius: DefaultConstants.defaultCornerRadius))
                .disabled(true)
            
            if let onExpandTapped {
                expandButton(action: onExpandTapped)
            }
        })
    }
    
    private func expandButton(action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: "arrow.down.left.and.arrow.up.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.g6)
                .frame(width: MapConstants.expandButtonSize, height: MapConstants.expandButtonSize)
                .glassEffect(.regular.interactive(), in: .circle)
        })
    }
    
    // MARK: - FullScreen Map View
    private var fullScreenMapView: some View {
        mapContent
            .ignoresSafeArea(.all)
            .safeAreaBar(edge: .top, content: {
                topControlSection
            })
            .safeAreaBar(edge: .bottom, content: {
                bottomControlSection
            })
            .loadingOverlay(isLoading: viewModel.isLoading, loadingTextType: .defaulLoading)
    }

    // MARK: - Top Control Section
    private var topControlSection: some View {
        VStack(alignment: .leading, spacing: MapConstants.topControlSpacing, content: {
            if !viewModel.totalDistance.isEmpty {
                routeInfoBanner
            }
//            
//            if !isCompact {
//                transportTypePicker
//            }
        })
        .safeAreaPadding(.horizontal, DefaultConstants.defaultSafeHorizon)
    }
    
    // MARK: - BottomSection
    private var bottomControlSection: some View {
        VStack(spacing: MapConstants.bottomControlVspacing, content: {
            HStack(content: {
                Spacer()
                mapControlButtons
            })
            .safeAreaPadding(.horizontal, DefaultConstants.defaultSafeHorizon)
            
            if viewModel.showPlaceDetail, let place = viewModel.selectedPlace {
                Text("시범")
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        })
    }
    
    // MARK: - Map Control Buttons
    private var mapControlButtons: some View {
        VStack(spacing: MapConstants.mapControlBottomSpacing, content: {
            /* 현재 위치 버튼 */
            mapControlButton(icon: "location.fill", action: {
                viewModel.moveCameraToCurrentLocation()
            })
            
            /* 전체 보기 */
            mapControlButton(icon: "arrow.up.left.and.arrow.down.right", action: {
                viewModel.fitAllPlaces()
            })
        })
    }
    
    private func mapControlButton(icon: String, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: icon)
                .font(.buttonText)
                .foregroundStyle(.g6)
                .frame(width: MapConstants.controlButtonSize, height: MapConstants.controlButtonSize)
                .glassEffect(.regular.interactive(), in: .circle)
        })
    }
    
    // MARK: - Route Info Banner
    private var routeInfoBanner: some View {
        HStack(spacing: MapConstants.routeInfoSpacing, content: {
            generateLabel(text: viewModel.totalDistance, image: "map")
            generateLabel(text: viewModel.totalDuration, image: "clock")
            Spacer()
            if viewModel.isNavigating {
                Button(action: {
                    Task {
                        await viewModel.stopNavigation()
                    }
                }, label: {
                    Text("종료")
                        .font(.caption1)
                        .fontWeight(.semibold)
                        .foregroundStyle(.red)
                })
                .buttonStyle(.glass)
            }
        })
    }
    
    private func generateLabel(text: String, image: String) -> some View {
        Label(title: {
            Text(text)
                .font(.caption1)
        }, icon: {
            Image(systemName: image)
                .font(.system(size: 12))
        })
        .foregroundStyle(.g6)
    }
    
    // MARK: - Transport Type Picker
    private var transportTypePicker: some View {
        HStack {
            ForEach(CourseTransportType.allCases, id: \.self) { type in
                Button(action: {
                    Task {
                        await viewModel.changeTransportType(type)
                    }
                }, label: {
                    Label(title: {
                        Text(type.rawValue)
                            .font(.caption1)
                            .fontWeight(.medium)
                    }, icon: {
                        Image(systemName: type.icon)
                            .font(.system(size: 14))
                    })
                    .labelIconToTitleSpacing(4)
                    .foregroundStyle(viewModel.transportType == type ? .m5 : .g6)
                    .disabled(viewModel.isLoading)
                })
            }
        }
    }
}

// MARK: - Preview
  #Preview("Compact") {
      let mockPlaces: [PlaceInfo] = [
          PlaceInfo(placeId: 1, placeName: "스타벅스 강남점", category: .CAFE,
  placeLatitude: 37.4979, placeLongitude: 127.0276, isVisited: true),
          PlaceInfo(placeId: 3, placeName: "루프탑 바", category: .BAR,
  placeLatitude: 37.5020, placeLongitude: 127.0250, isVisited: false)
      ]

      VStack(spacing: 16) {
          Text("코스 경로")
              .font(.headline)

          Text("지도를 클릭하여 길을 찾고 장소 정보를 확인해보세요!")
              .font(.caption)
              .foregroundStyle(.gray)

          CourseRouteMapView(
              places: mockPlaces,
              isCompact: true,
              onExpandTapped: { print("Expand") }
          )
      }
      .padding()
  }

// MARK: - CourseRouteFullScreenView
struct CourseRouteFullScreenView: View {

    let places: [PlaceInfo]
    @State private var locationManager = LocationManager()

    var body: some View {
        CourseRouteMapView(
            places: places,
            isCompact: false,
            locationManager: locationManager
        )
        .navigationTitle("코스 경로")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            locationManager.startUpdating()
        }
    }
}

  #Preview("Full Screen") {
      let mockPlaces: [PlaceInfo] = [
          PlaceInfo(placeId: 2, placeName: "명동교자", category: .RESTAURANT,
  placeLatitude: 37.5005, placeLongitude: 127.0290, isVisited: false),
//          PlaceInfo(placeId: 3, placeName: "루프탑 바", category: .BAR,
//  placeLatitude: 37.5020, placeLongitude: 127.0250, isVisited: true),
          PlaceInfo(placeId: 4, placeName: "CGV 강남", category: .CULTURELIFE,
  placeLatitude: 37.5010, placeLongitude: 127.0260, isVisited: false)
      ]

      NavigationStack {
          CourseRouteFullScreenView(places: mockPlaces)
      }
  }
