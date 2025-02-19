//
//  AppleMapViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 2/19/25.
//

import Foundation
import MapKit
import Combine

class AppleMapViewModel: ObservableObject {
    
    @Published var isFullScreenMap = false
    @Published var route: MKPolyline?
    @Published var routerIsLoading: Bool = false
    
    var placeInfoData: [PlaceInfoData]
    
    let container: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    init(placeInfoData: [PlaceInfoData], container: DIContainer) {
        self.placeInfoData = placeInfoData
        self.container = container
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
}
