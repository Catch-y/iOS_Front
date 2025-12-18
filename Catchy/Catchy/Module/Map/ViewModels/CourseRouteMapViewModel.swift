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
    // MARK: - Loading Property
    var isVisitingCheckLoading: Bool = false
    // MARK: - State
    var places: [PlaceInfo]
    var selectedPlace: PlaceInfo?
    var cameraPosition: MapCameraPosition
    var selectedDetailPlace: PlaceCourseDetailResponse? = .init(placeId: 1, imageUrl: nil, placeName: "심퍼티쿠시 용산점", placeDescription: "유러피언 요리를 아시안 스타일로 풀어내는 파인캐주얼 레스토랑", categoryName: .RESTAURANT, roadAddress: "서울시 용산구 한강대로52길 17-3 1F", activeTime: "월-금 16:00 - 21:00", placeSite: "http://www.naver.com", rating: 4.3, reviewCount: 203, placeLatitude: 1.1, placeLongitude: 1.1, liked: true, visited: true)
    
    // MARK: - RouteData
    var fullCourseRoute: MKPolyline?
    var navigationRoute: MKPolyline?
    
    // MARK: - UI State
    var loadingState: RouteLoadingState = .idle
    var transportType: CourseTransportType = .walking
    var isNavigating: Bool = false
    var showPlaceDetail: Bool = false
    var errorMessage: String?
    
    // MARK: - Route Info Display
    var totalDistance: String = ""
    var totalDuration: String = ""
    var totalSteps: String = ""

    // MARK: - Geofencing State
    var showGeofenceOverlay: Bool = false
    var geofenceCenter: CLLocationCoordinate2D?
    var geofenceRadius: CLLocationDistance = 100

    // MARK: - Dependency
    private let actor: CourseRouteMapActor
    private let locationManager: LocationManager
    
    // MARK:  - Init
    init(
        places: [PlaceInfo],
        container: DIContainer,
        locationManager: LocationManager = .init()
    ) {
        self.places = places
        self.actor = CourseRouteMapActor(container: container)
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
    
    // MARK: - Public Method (API Method)
    @MainActor
    public func postPlaceVisiting() async {
        guard let _ = selectedDetailPlace, canVisitCheck else { return }
        isVisitingCheckLoading = true
        
    }
    
    // MARK: - Public Methods (Geofencing)
    @MainActor
    func startGeofenceForPlace(_ place: PlaceInfo) async {
        let coordinate = CLLocationCoordinate2D(
            latitude: place.placeLatitude,
            longitude: place.placeLongitude
        )

        // 지도에 표시할 오버레이 정보 설정
        geofenceCenter = coordinate
        geofenceRadius = LocationManager.geofenceRadius
        showGeofenceOverlay = true

        // LocationManager를 통해 지오펜싱 모니터링 시작
        await locationManager.startGeofenceMonitoring(
            at: coordinate,
            identifier: "place_\(place.placeId)",
            radius: geofenceRadius
        )
    }

    @MainActor
    func stopGeofence() async {
        showGeofenceOverlay = false
        geofenceCenter = nil
        await locationManager.stopAllGeofenceMonitoring()
    }
    
    // MARK: - Public Methods (Route Loading)
    @MainActor
    func loadCourseRoute() async {
        guard places.count >= 2 else {
            fullCourseRoute = nil
            clearRouteInfo()
            return
        }

        loadingState = .loading
        errorMessage = nil

        do {
            await actor.clearCache()

            let routeInfo = try await actor.getRouteInfo(places: places)

            if !routeInfo.polylineCoordinates.isEmpty {
                fullCourseRoute = MKPolyline(
                    coordinates: routeInfo.polylineCoordinates, count: routeInfo.polylineCoordinates.count
                )
            }
            
            updateRouteInfo(from: routeInfo)
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
    
    // MARK: - Public Methods (Place Selection)
    @MainActor
    func selectPlace(_ place: PlaceInfo?) async {
        withAnimation(.easeInOut(duration: 0.25)) {
            selectedPlace = place
            showPlaceDetail = place != nil
        }

        if let place = place {
            moveCameraToPlace(place)
            await startGeofenceForPlace(place)
        } else {
            await stopGeofence()
        }
    }

    @MainActor
    func closePlaceDetail() async {
        withAnimation(.easeInOut(duration: 0.25)) {
            showPlaceDetail = false
            selectedPlace = nil
        }
        await stopGeofence()
    }

    @MainActor
    func selectNextPlace() async {
        guard let current = selectedPlace,
              let currentIndex = places.firstIndex(where: { $0.id == current.id }),
              currentIndex < places.count - 1 else {
            return
        }
        await selectPlace(places[currentIndex + 1])
    }

    @MainActor
    func selectPreviousPlace() async {
        guard let current = selectedPlace,
              let currentIndex = places.firstIndex(where: { $0.id == current.id}),
              currentIndex > 0 else {
            return
        }
        await selectPlace(places[currentIndex - 1])
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
                span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
            ))
        }
    }
    
    @MainActor
    func fitAllPlaces() async {
        let region = Self.calculateInitialRegion(for: places)
        withAnimation(.easeInOut(duration: 0.3)) {
            cameraPosition = .region(region)
            self.selectedPlace = nil
        }
        await stopGeofence()
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
            
            let routeInfo = try await actor.getRouteFromCurrentLocation(currentLocation: currentLoc, to: destination)
            
            if !routeInfo.polylineCoordinates.isEmpty {
                navigationRoute = MKPolyline(coordinates: routeInfo.polylineCoordinates, count: routeInfo.polylineCoordinates.count)
            }
            
            updateRouteInfo(from: routeInfo)
            loadingState = .loaded
            
            if let polyline = navigationRoute {
                fitRouteInView(polyline)
            }
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
        await fitAllPlaces()
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
        
        let latDelta = max((maxLat - minLat) * 1.2, 0.01)
        let lonDelta = max((maxLon - minLon) * 1.2, 0.01)
        
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
    
    private func updateRouteInfo(from routeInfo: RouteInfo) {
        let distance = routeInfo.totalDistance
        if distance >= 1000 {
            totalDistance = String(format: "%.1fkm", Double(distance) / 1000)
        } else {
            totalDistance = "\(distance)m"
        }
        
        let minutes = routeInfo.toalTime / 60
        if minutes >= 60 {
            let hours = minutes / 60
            let remainingMinutes = minutes % 60
            totalDuration = remainingMinutes > 0 ? "\(hours)시간 \(remainingMinutes)분" : "\(hours)시간"
        } else {
            totalDuration = "\(max(1, minutes))분"
        }
        
        let steps = routeInfo.totalSteps
        if steps >= 10000 {
            totalSteps = String(format: "%.1f만 걸음", Double(steps) / 10000)
        } else if steps >= 10000 {
            totalSteps = String(format: "%d,%03d 걸음", steps / 1000, steps % 1000)
        } else {
            totalSteps = "\(steps) 걸음"
        }
    }
    
    private func clearRouteInfo() {
        totalDistance = ""
        totalDuration = ""
        totalSteps = ""
    }
    
    @MainActor
    private func handleRouteError(_ error: Error) {
        let message = error.localizedDescription
        errorMessage = message
        loadingState = .failed(message)
    }
}

extension CourseRouteMapViewModel {
    var activeRoute: MKPolyline? {
        isNavigating ? navigationRoute : fullCourseRoute
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
        loadingState == .loading
    }
    
    var hasError: Bool {
        if case .failed = loadingState { return true }
        return false
    }
    
    var canShowRouteInfo: Bool {
        !totalDistance.isEmpty && !totalDuration.isEmpty
    }

    // MARK: - Geofencing Computed Properties
    /// 사용자가 지오펜스 내부에 있는지 여부
    var isUserInsideGeofence: Bool {
        locationManager.isInsideGeofence
    }

    /// 선택한 장소까지의 거리
    var distanceToSelectedPlace: CLLocationDistance? {
        guard let place = selectedDetailPlace else { return nil }
        let coordinate = CLLocationCoordinate2D(
            latitude: place.placeLatitude,
            longitude: place.placeLongitude
        )
        return locationManager.distance(to: coordinate)
    }

    /// 포맷된 거리 문자열
    var formattedDistance: String {
        guard let distance = distanceToSelectedPlace else { return "" }
        if distance >= 1000 {
            return String(format: "%.1fkm", distance / 1000)
        } else {
            return String(format: "%.0fm", distance)
        }
    }

    /// 방문 체크 가능 여부 (지오펜스 내부 + 아직 방문 안 함)
    var canVisitCheck: Bool {
        guard let place = selectedDetailPlace else { return false }
        return isUserInsideGeofence && !place.visited
    }
}
