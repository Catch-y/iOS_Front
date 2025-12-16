//
//  CourseRouteMapActor.swift
//  Catchy
//
//  Created by euijjang97 on 12/15/25.
//

import MapKit
import Combine

actor CourseRouteMapActor {
    // MARK: - Dependencies
    private let container: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Cache
    private var routeCache: [String: RouteInfo] = [:]
    
    // MARK: - Init
    init(container: DIContainer) {
        self.container = container
    }
    
    // MARK: - Public Method
    public func getRouteInfo(places: [PlaceInfo], transportType: CourseTransportType = .walking) async throws -> RouteInfo {
        guard places.count >= 2 else {
            throw RouteError.insufficientPlaces
        }
        
        let cacheKey = generateCacheKey(places: places, transportType: transportType)
        
        if let cached = routeCache[cacheKey] {
            return cached
        }
        
        let startPlace = places.first!
        let endPlace = places.last!
        
        var passPoints: [(lon: Double, lat: Double)]? = nil
        if places.count > 2 {
            passPoints = places.dropFirst().dropLast().map { place in
                (lon: place.placeLongitude, lat: place.placeLatitude)
            }
        }
        
        let tmap = TMapRouteRequest(
            startX: startPlace.placeLongitude,
            startY: startPlace.placeLatitude,
            endX: endPlace.placeLongitude,
            endY: endPlace.placeLatitude,
            startName: startPlace.placeName,
            endName: endPlace.placeName,
            passPoints: passPoints
        )
        
        let response = try await requestTmapRoute(tmap: tmap)
        return parseRouteResponse(response)
    }
    
    public func getRouteFromCurrentLocation(
        currentLocation: CLLocationCoordinate2D,
        to destination: PlaceInfo
    ) async throws -> RouteInfo {
        let tmap = TMapRouteRequest(
            startX: currentLocation.longitude,
            startY: currentLocation.latitude,
            endX: destination.placeLongitude,
            endY: destination.placeLatitude,
            startName: "현재 위치",
            endName: destination.placeName
        )
        
        let response = try await requestTmapRoute(tmap: tmap)
        return parseRouteResponse(response)
    }
    
    public func clearCache() {
        routeCache.removeAll()
    }
    
    // MARK: - Private Method
    private func generateCacheKey(places: [PlaceInfo], transportType: CourseTransportType) -> String {
        let placeIds = places.map { "\($0.placeId)" }.joined(separator: "-")
        return "\(placeIds)_\(transportType.rawValue)"
    }
    
    private func requestTmapRoute(tmap: TMapRouteRequest) async throws -> TMapRouteResponse {
        try await withCheckedThrowingContinuation { continuation in
            container.useCaseProvider.tmapUseCase.executePostTmap(tmap: tmap)
                .sink(receiveCompletion: { completion in
                    if case .failure(let failure) = completion {
                        continuation.resume(throwing: failure)
                    }
                }, receiveValue: { response in
                    continuation.resume(returning: response)
                }
            )
                .store(in: &cancellables)
        }
    }
    
    private func parseRouteResponse(_ response: TMapRouteResponse) -> RouteInfo {
        var totalDistance: Int = 0
        var totalTime: Int = 0
        var allCoordinates: [CLLocationCoordinate2D] = .init()
        
        for feature in response.features {
            let properties = feature.properties
            
            if properties.index == 0,
               let distance = properties.totalDistance,
               let time = properties.totalTime {
                totalDistance = distance
                totalTime = time
            }
            
            if case .lineString = feature.geometry {
                allCoordinates.append(contentsOf: feature.geometry.pathCoordinates)
            }
        }
        
        let averageStrideLength: Double = 0.65
        let totalSteps = Int(Double(totalDistance) / averageStrideLength)
        
        return RouteInfo(
            totalDistance: totalDistance,
            toalTime: totalTime,
            totalSteps: totalSteps,
            polylineCoordinates: allCoordinates
        )
    }
}
