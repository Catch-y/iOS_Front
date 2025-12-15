//
//  CourseRouteMapViewModel.swift
//  Catchy
//
//  Created by euijjang97 on 12/15/25.
//

import Foundation
import SwiftUI
import MapKit

@Observable
final class CourseRouteMapViewModel {
    // MARK: - State
    var places: [PlaceInfo]
    var selectedPlace: PlaceInfo?
    var cameraPosition: MapCameraPosition
    
    // MARK: - RouteData
    var routeSegmenets: [RouteSegment] = .init()
    var fullCourseRoute: CalculatedRoute?
    var navigationRoute: CalculatedRoute?
    
    // MARK: - UI State
    var loadingState: RouteLoadingState = .idle
    var transportType: CourseTransportType = .walking
    var isNavigating: Bool = false
    var showPlaceDetail: Bool = false
    var errorMessage: String?
    
    // MARK: - Route Info Display
    var totalDistance: String = ""
    var totalDuration: String = ""
    
    // MARK: - Dependency
    private let actor: CourseRouteMapActor
    private let locationManager: LocationManager
    
    // MARK:  - Init
    init(
        places: [PlaceInfo],
        actor: CourseRouteMapActor = .init(),
        locationManager: LocationManager = .init()
    ) {
        self.places = places
        self.actor = actor
        self.locationManager = locationManager
        
        let region = Self.calculateInitialRegion(for: places)
        self.cameraPosition = .region(region)
    }
    
    // MARK: - Location Accessros
    var currentLocation: CLLocationCoordinate2D? {
        locationManager.currentLocation
    }
    
    var isLocationAuthorized: Bool {
        locationManager.isAuthorized
    }
    
    // MARK: - Public Methods (Route Loading)
    
    @MainActor
    func loadCourseRoute() async {
        guard places.count >= 2 else {
            routeSegmenets = []
            fullCourseRoute = nil
            clearRouteInfo()
            return
        }
        
        loadingState = .loading
        errorMessage = nil
        
        do {
            let segments = try await actor.calculateCourseSegments(
                places: places, transportType: transportType
            )
            routeSegmenets = segments
            
            let fullRoute = try await actor.calculateFullCourseRoute(
                places: places,
                transportType: transportType
            )
            fullCourseRoute = fullRoute
            
            updateRouteInfo(distance: fullRoute.distance, duration: fullRoute.expectedTravelTime)
            loadingState = .loaded
        } catch {
            handleRouteError(error)
        }
    }
    
    @MainActor
    func refreshRoute() async {
        await actor.clearCache()
        await loadCourseRoute()
    }
    
    // MARK: - Public Method (Transport Type)
    @MainActor
    func changeTransportType(_ type: CourseTransportType) async {
        guard transportType != type else { return }
        
        transportType = type
        
        if isNavigating {
            await startNavigationToSelectedPlace()
        } else {
            await loadCourseRoute()
        }
    }
    
    // MARK: - Pulic Methods (Place Selection)
    @MainActor
    func selectPlace(_ place: PlaceInfo?) {
        withAnimation(.easeInOut(duration: 0.25)) {
            selectedPlace = place
            showPlaceDetail = place != nil
        }
        
        if let place = place {
            moveCameraToPlace(place)
        }
    }
    
    @MainActor
    func closePlaceDetail() {
        withAnimation(.easeInOut(duration: 0.25)) {
            showPlaceDetail = false
            selectedPlace = nil
        }
    }
    
    @MainActor
    func selectNextPlace() {
        guard let current = selectedPlace,
              let currentIndex = places.firstIndex(where: { $0.id == current.id }),
              currentIndex < places.count - 1 else {
            return
        }
        selectPlace(places[currentIndex + 1])
    }
    
    @MainActor
    func selectPreviousPlace() {
        guard let current = selectedPlace,
              let currentIndex = places.firstIndex(where: { $0.id == current.id}),
              currentIndex > 0 else {
            return
        }
        selectPlace(places[currentIndex - 1])
    }
    
    // MARK: - Public Method (Camera Control)
    @MainActor
    func moveCameraToPlace(_ place: PlaceInfo) {
        withAnimation(.easeInOut(duration: 0.3)) {
            cameraPosition = .region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: place.placeLatitude,
                    longitude: place.placeLongitude
                ),
                span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
            ))
        }
    }
    
    @MainActor
    func fitAllPlaces() {
        let region = Self.calculateInitialRegion(for: places)
        withAnimation(.easeInOut(duration: 0.3)) {
            cameraPosition = .region(region)
        }
    }
    
    @MainActor
    func moveCameraToCurrentLocation() {
        guard let location = currentLocation else {
            locationManager.requestAuthorization()
            return
        }
        
        withAnimation(.easeInOut(duration: 0.3)) {
            cameraPosition = .region(MKCoordinateRegion(
                center: location,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            ))
        }
    }
    
    // MARK: - Public Methods (Navigation)
    @MainActor
    func startNavigationToSelectedPlace() async {
        guard let destination = selectedPlace else { return }
        await startNavigation(to: destination)
    }
    
    @MainActor
    func startNavigation(to destination: PlaceInfo) async {
        do {
            let currentLoc = try await locationManager.requestCurrentLocation()
            isNavigating = true
            loadingState = .loading
            errorMessage = nil
            
            let route = try await actor.calculateRouteFromCurrentLocation(
                currentLocation: currentLoc,
                to: destination,
                transportType: transportType
            )
            
            navigationRoute = route
            updateRouteInfo(distance: route.distance, duration: route.expectedTravelTime)
            loadingState = .loaded
            
            fitRouteInView(route.polyline)
        } catch {
            handleRouteError(error)
            isNavigating = false
        }
    }
    
    @MainActor
    func startNavigationThroughCourse() async {
        guard !places.isEmpty else { return }
        
        do {
            let currentLoc = try await locationManager.requestCurrentLocation()
            isNavigating = true
            loadingState = .loading
            errorMessage = nil
            
            let route = try await actor.calculateRouteFromCurrentLocation(
                currentLocation: currentLoc,
                through: places,
                transportType: transportType
            )
            
            navigationRoute = route
            updateRouteInfo(distance: route.distance, duration: route.expectedTravelTime)
            loadingState = .loaded
            
            fitRouteInView(route.polyline)
        } catch {
            handleRouteError(error)
            isNavigating = false
        }
    }
    
    @MainActor
    func stopNavigation() async {
        isNavigating = false
        navigationRoute = nil
        errorMessage = nil
        
        await loadCourseRoute()
        fitAllPlaces()
    }
    
    // MARK: - Public Methods (Location)
    func requestLocationPermission() {
        locationManager.requestAuthorization()
    }
    
    func startLocationUpdates() {
        locationManager.startUpdating()
    }
    
    func stopLocationUpdates() {
        locationManager.stopUpdating()
    }
    
    // MARK: - Public Methods (Segment Info)
    func getSegmentInfo(at index: Int) -> RouteSegment? {
        guard index >= 0 && index < routeSegmenets.count else { return nil }
        return routeSegmenets[index]
    }
    
    func getSegmentBetween(from: PlaceInfo, to: PlaceInfo) -> RouteSegment? {
        routeSegmenets.first { segment in
            segment.fromPlace.placeId == from.placeId &&
            segment.toPlace.placeId == to.placeId
        }
    }
    
    // MARK: - Private Method
    private static func calculateInitialRegion(for places: [PlaceInfo]) -> MKCoordinateRegion {
        guard !places.isEmpty else {
            return MKCoordinateRegion(
                center: .init(latitude: 37.5665, longitude: 126.9780),
                span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
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
        
        let latDelta = max((maxLat - minLat) * 1.5, 0.02)
        let lonDelta = max((maxLon - minLon) * 1.5, 0.02)
        
        return MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        )
    }
    
    @MainActor
    private func fitRouteInView(_ polyline: MKPolyline) {
        let rect = polyline.boundingMapRect
        let paddedRect = rect.insetBy(
            dx: -rect.width * 0.2,
            dy: -rect.height * 0.2
        )
        
        withAnimation(.easeInOut(duration: 0.3)) {
            cameraPosition = .rect(paddedRect)
        }
    }
    
    private func updateRouteInfo(distance: Double, duration: Double) {
        if distance >= 1000 {
            totalDistance = String(format: "%.1fkm", distance / 1000)
        } else {
            totalDistance = String(format: "%.0fm", distance)
        }
        
        let minutes = Int(duration / 60)
        if minutes >= 60 {
            let hours = minutes / 60
            let remaningMinutes = minutes % 60
            totalDuration = remaningMinutes > 0 ? "\(hours)시간 \(remaningMinutes)분" : "\(hours)시간"
        } else {
            totalDuration = "\(max(1, minutes))분"
        }
    }
    
    private func clearRouteInfo() {
        totalDistance = ""
        totalDuration = ""
    }
    
    @MainActor
    private func handleRouteError(_ error: Error) {
        let message = error.localizedDescription
        errorMessage = message
        loadingState = .failed(message)
    }
}

extension CourseRouteMapViewModel {
    var activeRoute: CalculatedRoute? {
        isNavigating ? navigationRoute : fullCourseRoute
    }
    
    var activePolyline: [MKPolyline] {
        if isNavigating, let navRoute = navigationRoute {
            return [navRoute.polyline]
        }
        return routeSegmenets.map { $0.polyline }
    }
    
    var selectedPlaceIndex: Int? {
        guard let selected = selectedPlace else { return nil }
        return places.firstIndex(where: { $0.id == selected.id })
    }
    
    var isFirstPlaceSelected: Bool {
        selectedPlaceIndex == 0
    }
    
    var isLastPlaceSelected: Bool {
        guard let index = selectedPlaceIndex else { return false }
        return index == places.count - 1
    }
    
    var isLoading: Bool {
        loadingState == .loaded
    }
    
    var hasError: Bool {
        if case .failed = loadingState { return true }
        return false
    }
    
    var canShowRouteInfo: Bool {
        !totalDistance.isEmpty && !totalDuration.isEmpty
    }
}
