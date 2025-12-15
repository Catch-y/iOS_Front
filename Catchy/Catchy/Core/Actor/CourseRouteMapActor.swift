//
//  CourseRouteMapActor.swift
//  Catchy
//
//  Created by euijjang97 on 12/15/25.
//

import Foundation
import CoreLocation
import MapKit

actor CourseRouteMapActor {
    private var segmenetCache: [String: [RouteSegment]] = .init()
    private var routeCache: [String: CalculatedRoute] = .init()
    
    // MARK: - Public Methods
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
        
        let segments = try await calculateCourseSegments(places: places, transportType: transportType)
        
        let combinePolyline = combinePolylines(from: segments)
        let totalDistance = segments.reduce(0) { $0 + $1.distance }
        let totalDuration = segments.reduce(0) { $0 + $1.expectedTravelTime }
        
        let waypoints = places.count > 2 ? Array(places.dropFirst().dropLast()) : []
        
        let calculateRoute = CalculatedRoute(
            polyline: combinePolyline,
            distance: totalDistance,
            expectedTravelTime: totalDuration,
            transportType: transportType,
            fromPlace: places.first,
            waypoints: waypoints,
            toPlace: places.last
        )
        
        return calculateRoute
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
