//
//  AppleMapViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 2/19/25.
//

import Foundation
import MapKit
import Combine
import CoreLocation

class AppleMapViewModel: ObservableObject {
    
    @Published var route: MKPolyline?
    @Published var routerIsLoading: Bool = false
    @Published var selectedPlaceId: Int?
    
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var userHeading: CLLocationDirection = 0
    
    var placeInfoData: [PlaceInfoData]
    
    let container: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    init(placeInfoData: [PlaceInfoData], container: DIContainer) {
        self.placeInfoData = placeInfoData
        self.container = container
    }
    
    private func observeLocationUpdates() {
            BaseLocationManager.shared.$currentLocation
                .compactMap { $0?.coordinate }
                .assign(to: &$userLocation)

            BaseLocationManager.shared.$currentHeading
                .compactMap { $0?.trueHeading }
                .assign(to: &$userHeading)
        }
    
    /// 지도 초기 영역 설정
    var initialRegion: MKCoordinateRegion {
        guard !placeInfoData.isEmpty else {
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 33.508300, longitude: 126.951630),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }
        return calculateRegion(for: placeInfoData.map { $0.coordinate })
    }

    /// 주어진 좌표를 포함하는 MKCoordinateRegion 계산
    private func calculateRegion(for coordinates: [CLLocationCoordinate2D]) -> MKCoordinateRegion {
        var minLat = coordinates.first!.latitude
        var maxLat = coordinates.first!.latitude
        var minLon = coordinates.first!.longitude
        var maxLon = coordinates.first!.longitude

        for coordinate in coordinates {
            minLat = min(minLat, coordinate.latitude)
            maxLat = max(maxLat, coordinate.latitude)
            minLon = min(minLon, coordinate.longitude)
            maxLon = max(maxLon, coordinate.longitude)
        }

        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )

        let latDelta = (maxLat - minLat) * 1.5
        let lonDelta = (maxLon - minLon) * 1.5

        return MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        )
    }
    
    func fitMapToRoute(in mapView: MKMapView) {
        guard let route = route else { return }

        let mapRect = route.boundingMapRect
        let edgePadding = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        mapView.setVisibleMapRect(mapRect, edgePadding: edgePadding, animated: true)
    }
    
    func centerMapBetweenStartAndEnd(in mapView: MKMapView) {
        guard placeInfoData.count >= 2 else { return }

        let start = placeInfoData.first!.coordinate
        let end = placeInfoData.last!.coordinate

        let center = CLLocationCoordinate2D(
            latitude: (start.latitude + end.latitude) / 2,
            longitude: (start.longitude + end.longitude) / 2
        )

        let latDelta = abs(start.latitude - end.latitude) * 1.5
        let lonDelta = abs(start.longitude - end.longitude) * 1.5

        let region = MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        )

        mapView.setRegion(region, animated: true)
    }
    
    func adjustMapForSelectedAnnotation(in mapView: MKMapView) {
           guard let selectedPlace = placeInfoData.first(where: { $0.placeId == selectedPlaceId }) else { return }

           let annotationCoordinate = selectedPlace.coordinate

           // 지도 중심을 위로 이동 (현재 위치에서 위로 20% 정도 올림)
           let offsetLatitude = annotationCoordinate.latitude + (mapView.region.span.latitudeDelta * 0.25)
           
           let newCenter = CLLocationCoordinate2D(latitude: offsetLatitude, longitude: annotationCoordinate.longitude)

           let newRegion = MKCoordinateRegion(
               center: newCenter,
               span: mapView.region.span
           )

           mapView.setRegion(newRegion, animated: true)
       }
    
        /// 현재 위치를 지도 중심으로 설정
        func setUserLocation(_ location: CLLocation) {
            DispatchQueue.main.async {
                self.userLocation = location.coordinate
            }
        }
        
        /// 특정 장소에 포커스
        func focusOnPlace(_ place: PlaceInfoData) {
            DispatchQueue.main.async {
                self.userLocation = place.coordinate
            }
        }
  
  
}

// MARK: - OSRM 응답 처리 및 Polyline 업데이트
extension AppleMapViewModel {
    
    /// OSRM 응답을 바탕으로 Polyline 업데이트
    func updatePolyline(with response: OSRMResponse) {
        guard let firstRoute = response.routes.first else {
            print("❌ No OSRM response")
            return
        }

        /* geometry만 사용하여 polyline을 생성 */
        let coordinates = firstRoute.geometry.coordinates.map {
            CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0])
        }

        if !coordinates.isEmpty {
            let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
            DispatchQueue.main.async {
                self.route = polyline
            }
        } else {
            print("❌ coordinates for polyline")
        }
    }
    
    /// OSRM 최단 경로 요청
    func fetchRoute() {
        
        guard placeInfoData.count >= 2 else { return }
        
        routerIsLoading = true
        
        let start = placeInfoData.first!
        let end = placeInfoData.last!
        
        let request = OSRMRequest(
            start: OSRMCoordinate(longitude: start.placeLongitude, latitude: start.placeLatitude),
            routes: [],
            end: OSRMCoordinate(longitude: end.placeLongitude, latitude: end.placeLatitude)
        )
        
        container.useCaseProvider.routeUseCase.executeOsrmRouter(locationData: request)
            .tryMap { responseData -> ResponseData<OSRMResponse> in
                if !responseData.isSuccess {
                    throw APIError.serverError(message: responseData.message, code: responseData.code)
                }
                guard let _ = responseData.result else {
                    throw APIError.emptyResult
                }
                print("✅ OSRM Route: \(responseData)")
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                
                self.routerIsLoading = false
                
                switch completion {
                case .finished:
                    print("✅ OSRM Route Completed")
                case .failure(let failure):
                    print("❌ OSRM Route Failed: \(failure)")
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                if let response = response.result {
                    self.updatePolyline(with: response)
                }
            })
            .store(in: &cancellables)
    }
    
    /// 현재 위치에서 선택된 장소 길 찾기
    func findRouteToSelectedPlace() {
            guard let selectedPlace = placeInfoData.first(where: { $0.placeId == selectedPlaceId }) else {
                print("❌ 선택된 장소가 없습니다.")
                return
            }

            BaseLocationManager.shared.getCurrentUserLocation { [weak self] userLocation in
                guard let self = self, let userLocation = userLocation else {
                    print("❌ 현재 위치를 가져올 수 없습니다.")
                    return
                }

                let startCoordinate = OSRMCoordinate(longitude: userLocation.coordinate.longitude, latitude: userLocation.coordinate.latitude)
                let destinationCoordinate = OSRMCoordinate(longitude: selectedPlace.placeLongitude, latitude: selectedPlace.placeLatitude)

                let request = OSRMRequest(start: startCoordinate, routes: [], end: destinationCoordinate)

                self.container.useCaseProvider.routeUseCase.executeOsrmRouter(locationData: request)
                    .tryMap { responseData -> ResponseData<OSRMResponse> in
                        if !responseData.isSuccess {
                            throw APIError.serverError(message: responseData.message, code: responseData.code)
                        }
                        guard let _ = responseData.result else {
                            throw APIError.emptyResult
                        }
                        return responseData
                    }
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            print("✅ 경로 찾기 완료")
                        case .failure(let failure):
                            print("❌ 경로 찾기 실패: \(failure)")
                        }
                    }, receiveValue: { response in
                        if let response = response.result {
                            self.updatePolyline(with: response)
                        }
                    })
                    .store(in: &cancellables)
            }
        }
}
