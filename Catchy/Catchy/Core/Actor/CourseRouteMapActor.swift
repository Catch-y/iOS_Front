//
//  CourseRouteMapActor.swift
//  Catchy
//
//  Created by euijjang97 on 12/15/25.
//

import Foundation
import CoreLocation
import MapKit

/// MKRoute와 호환되는 간소화된 경로 구조체
private class SimplifiedRoute: MKRoute {
    private let _polyline: MKPolyline
    private let _distance: CLLocationDistance
    private let _expectedTravelTime: TimeInterval

    init(polyline: MKPolyline, distance: CLLocationDistance, expectedTravelTime: TimeInterval) {
        self._polyline = polyline
        self._distance = distance
        self._expectedTravelTime = expectedTravelTime
        super.init()
    }

    override var polyline: MKPolyline { _polyline }
    override var distance: CLLocationDistance { _distance }
    override var expectedTravelTime: TimeInterval { _expectedTravelTime }
}

actor CourseRouteMapActor {
    private var segmenetCache: [String: [RouteSegment]] = .init()
    private var routeCache: [String: CalculatedRoute] = .init()
    
    // MARK: - Public Methods

    /// 경유지 순서 최적화 (Nearest Neighbor TSP 휴리스틱)
    /// 첫 번째 장소를 시작점으로 고정하고, 가장 가까운 장소를 순차적으로 선택
    public func optimizePlaceOrder(places: [PlaceInfo]) -> [PlaceInfo] {
        guard places.count > 2 else { return places }

        var optimized: [PlaceInfo] = []
        var remaining = Array(places.dropFirst())

        guard let first = places.first else { return places }
        optimized.append(first)

        var current = first

        while !remaining.isEmpty {
            guard let nearest = remaining.min(by: {
                calculateDistance(from: current, to: $0) < calculateDistance(from: current, to: $1)
            }) else { break }

            optimized.append(nearest)
            remaining.removeAll { $0.placeId == nearest.placeId }
            current = nearest
        }

        return optimized
    }

    /// 두 장소 간 거리 계산 (Haversine formula)
    private func calculateDistance(from: PlaceInfo, to: PlaceInfo) -> Double {
        let lat1 = from.placeLatitude * .pi / 180
        let lon1 = from.placeLongitude * .pi / 180
        let lat2 = to.placeLatitude * .pi / 180
        let lon2 = to.placeLongitude * .pi / 180

        let dLat = lat2 - lat1
        let dLon = lon2 - lon1

        let a = sin(dLat / 2) * sin(dLat / 2) +
                cos(lat1) * cos(lat2) *
                sin(dLon / 2) * sin(dLon / 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))

        let R = 6371000.0 // 지구 반지름 (미터)
        return R * c
    }

    public func calculateCourseSegments(places: [PlaceInfo], transportType: CourseTransportType = .walking) async throws -> [RouteSegment] {
        guard places.count >= 2 else {
            throw RouteError.insufficientPlaces
        }
        
        let cacheKey = generateSegmentCacheKey(places: places, transportType: transportType)
        
        if let cached = segmenetCache[cacheKey] {
            return cached
        }
        
        var segments: [RouteSegment] = .init()
        
        for i in 0..<(places.count - 1) {
            let fromPlace = places[i]
            let toPlace = places[i+1]
            
            let route = try await requestDirection(from: .init(latitude: fromPlace.placeLatitude, longitude: fromPlace.placeLongitude), to: .init(latitude: toPlace.placeLatitude, longitude: toPlace.placeLongitude), transportType: transportType)
            
            let segment = RouteSegment(polyline: route.polyline, distance: route.distance, expectedTravelTime: route.expectedTravelTime, fromPlace: fromPlace, toPlace: toPlace, segmentIndex: i)
            
            segments.append(segment)
        }
        
        segmenetCache[cacheKey] = segments
        
        return segments
    }
    
    public func calculateFullCourseRoute(places: [PlaceInfo], transportType: CourseTransportType = .walking) async throws -> CalculatedRoute {
        guard places.count >= 2 else {
            throw RouteError.insufficientPlaces
        }

        let cacheKey = generateRouteCacheKey(places: places, transportType: transportType)
        if let cached = routeCache[cacheKey] {
            return cached
        }

        // 전달받은 places 순서대로 경로 계산 (최적화는 ViewModel에서 처리)
        let route = try await requestDirectionWithWaypoints(
            places: places,
            transportType: transportType
        )

        let waypoints = places.count > 2 ? Array(places.dropFirst().dropLast()) : []

        let calculatedRoute = CalculatedRoute(
            polyline: route.polyline,
            distance: route.distance,
            expectedTravelTime: route.expectedTravelTime,
            transportType: transportType,
            fromPlace: places.first,
            waypoints: waypoints,
            toPlace: places.last
        )

        routeCache[cacheKey] = calculatedRoute

        return calculatedRoute
    }

    /// 경유지를 포함한 경로 요청 (순차적으로 연결)
    private func requestDirectionWithWaypoints(places: [PlaceInfo], transportType: CourseTransportType) async throws -> MKRoute {
        guard places.count >= 2 else {
            throw RouteError.insufficientPlaces
        }

        // 각 구간별로 경로를 계산하고 합침
        var allPolylines: [MKPolyline] = []
        var totalDistance: Double = 0
        var totalDuration: Double = 0

        for i in 0..<(places.count - 1) {
            let from = places[i]
            let to = places[i + 1]

            let route = try await requestDirection(
                from: CLLocationCoordinate2D(latitude: from.placeLatitude, longitude: from.placeLongitude),
                to: CLLocationCoordinate2D(latitude: to.placeLatitude, longitude: to.placeLongitude),
                transportType: transportType
            )

            allPolylines.append(route.polyline)
            totalDistance += route.distance
            totalDuration += route.expectedTravelTime
        }

        let combinedPolyline = combinePolylinesFromArray(allPolylines)

        // MKRoute를 직접 반환할 수 없으므로, 임시 래퍼 사용
        return SimplifiedRoute(
            polyline: combinedPolyline,
            distance: totalDistance,
            expectedTravelTime: totalDuration
        )
    }
    
    public func calculateRouteBetween(
        from: PlaceInfo,
        to: PlaceInfo,
        transportType: CourseTransportType = .walking
    ) async throws -> CalculatedRoute {
        let cacheKey = "\(from.placeId)-\(to.placeId)-\(transportType.rawValue)"
        
        if let cached = routeCache[cacheKey] {
            return cached
        }
        
        let route = try await requestDirection(
            from: CLLocationCoordinate2D(
                latitude: from.placeLatitude,
                longitude: from.placeLongitude
            ),
            to: CLLocationCoordinate2D(latitude: to.placeLatitude, longitude: to.placeLongitude),
            transportType: transportType
        )
        
        let calculateRoute = CalculatedRoute(
            polyline: route.polyline,
            distance: route.distance,
            expectedTravelTime: route.expectedTravelTime,
            transportType: transportType,
            fromPlace: from,
            toPlace: to
        )
        
        routeCache[cacheKey] = calculateRoute
        
        return calculateRoute
    }
    
    func calculateRouteFromCurrentLocation(currentLocation: CLLocationCoordinate2D, to destination: PlaceInfo, transportType: CourseTransportType = .walking) async throws -> CalculatedRoute {
        let route = try await requestDirection(
            from: currentLocation,
            to: CLLocationCoordinate2D(latitude: destination.placeLatitude, longitude: destination.placeLongitude), transportType: transportType
        )
        
        return CalculatedRoute(
            polyline: route.polyline,
            distance: route.distance,
            expectedTravelTime: route.expectedTravelTime,
            transportType: transportType,
            fromPlace: nil,
            toPlace: destination
        )
    }
    
    func calculateRouteFromCurrentLocation(currentLocation: CLLocationCoordinate2D, through places: [PlaceInfo], transportType: CourseTransportType = .walking) async throws -> CalculatedRoute {
        guard !places.isEmpty else {
            throw RouteError.insufficientPlaces
        }
        
        var allSegmentPolylines: [MKPolyline] = .init()
        var totalDistance: Double = 0
        var totalDuration: Double = 0
        
        let firstRoute = try await requestDirection(
            from: currentLocation,
            to: CLLocationCoordinate2D(latitude: places[0].placeLatitude, longitude: places[0].placeLongitude), transportType: transportType
        )
        allSegmentPolylines.append(firstRoute.polyline)
        totalDistance += firstRoute.distance
        totalDuration += firstRoute.expectedTravelTime
        
        if places.count >= 2 {
            let courseSegments = try await calculateCourseSegments(
                places: places,
                transportType: transportType
            )
            
            for segment in courseSegments {
                allSegmentPolylines.append(segment.polyline)
                totalDistance += segment.distance
                totalDuration += segment.expectedTravelTime
            }
        }
        
        let combinedPolyline = combinePolylinesFromArray(allSegmentPolylines)
        let waypoints = places.count > 1 ? Array(places.dropLast()) : []
        
        return CalculatedRoute(
            polyline: combinedPolyline,
            distance: totalDistance,
            expectedTravelTime: totalDuration,
            transportType: transportType,
            fromPlace: nil,
            waypoints: waypoints,
            toPlace: places.last
        )
    }
    
    func calcualteVisibleRegion(
        for places: [PlaceInfo],
        padding: Double = 1.3,
    ) -> MKCoordinateRegion {
        guard !places.isEmpty else {
            return defaultRegion
        }
        
        let latitudes = places.map { $0.placeLatitude }
        let longitudes = places.map { $0.placeLongitude }
        
        let minLat = latitudes.min() ?? 0
        let maxLat = latitudes.max() ?? 0
        let minLon = longitudes.min() ?? 0
        let maxLon = longitudes.max() ?? 0
        
        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )
        
        let latDelta = max((maxLat - minLat) * padding, 0.01)
        let lonDelta = max((maxLon - minLon) * padding, 0.01)
        
        return MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta))
    }
    
    /// Polyline이 보이는 영역 계산
       func calculateVisibleRegion(
           for polyline: MKPolyline,
           padding: Double = 1.2
       ) -> MKMapRect {
           let rect = polyline.boundingMapRect
           return rect.insetBy(
               dx: -rect.width * (padding - 1),
               dy: -rect.height * (padding - 1)
           )
       }
    
    // MARK: - Clear
    public func clearCache() {
        segmenetCache.removeAll()
        routeCache.removeAll()
    }
    
    public func invalidateCaches(for places: [PlaceInfo]) {
        let keysToRemove = segmenetCache.keys.filter { key in
            places.contains { place in
                key.contains("\(place.placeId)")
            }
        }
        
        keysToRemove.forEach { segmenetCache.removeValue(forKey: $0) }
        
        let routeKeyToRemove = routeCache.keys.filter { key in
            places.contains { place in
                key.contains("\(place.placeId)")
            }
        }
        routeKeyToRemove.forEach { routeCache.removeValue(forKey: $0) }
    }
    
    // MARK: - Private Method
    private var defaultRegion: MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    }
    
    private func requestDirection(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, transportType: CourseTransportType) async throws -> MKRoute {
        let requst = MKDirections.Request()
        
        let sourceLocation = CLLocation(latitude: source.latitude, longitude: source.longitude)
        let destinationLocation = CLLocation(latitude: destination.latitude, longitude: destination.longitude)
        
        requst.source = MKMapItem(location: sourceLocation, address: nil)
        requst.destination = MKMapItem(location: destinationLocation, address: nil)
        requst.transportType = transportType.mkTransportType
        requst.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: requst)
        
        do {
            let response = try await directions.calculate()
            guard let route = response.routes.first else {
                throw RouteError.noRouteFound
            }
            return route
        } catch let error as MKError {
            switch error.code {
            case .directionsNotFound:
                throw RouteError.noRouteFound
            case .placemarkNotFound:
                throw RouteError.directionsError("장소를 찾을 수 없습니다.")
            default:
                throw RouteError.directionsError(error.localizedDescription)
            }
        } catch {
            throw RouteError.networkError(error.localizedDescription)
        }
    }
    
    private func combinePolylines(from segments: [RouteSegment]) -> MKPolyline {
        let polylines = segments.map { $0.polyline }
        return combinePolylinesFromArray(polylines)
    }
    
    private func combinePolylinesFromArray(_ polylines: [MKPolyline]) -> MKPolyline {
        var allCoordinates: [CLLocationCoordinate2D] = .init()
        
        for polyline in polylines {
            var coords = [CLLocationCoordinate2D](
                repeating: CLLocationCoordinate2D(), count: polyline.pointCount
            )
            
            polyline.getCoordinates(
                &coords,
                range: NSRange(location: .zero, length: polyline.pointCount)
            )
            
            if let lastCoord = allCoordinates.last,
               let firstCoord = coords.first,
               lastCoord.latitude == firstCoord.latitude,
               lastCoord.longitude == firstCoord.longitude {
                coords.removeFirst()
            }
            
            allCoordinates.append(contentsOf: coords)
        }
        
        return MKPolyline(coordinates: allCoordinates, count: allCoordinates.count)
    }
    
    private func generateSegmentCacheKey(places: [PlaceInfo], transportType: CourseTransportType) -> String {
        let placeIds = places.map { "\($0.placeId)" }.joined(separator: "-")
        return "segments_\(placeIds)_\(transportType.rawValue)"
    }
    
    private func generateRouteCacheKey(places: [PlaceInfo], transportType: CourseTransportType) -> String {
        let placeIds = places.map { "\($0.placeId)" }.joined(separator: "-")
        return "route_\(placeIds)_\(transportType.rawValue)"
    }
}
