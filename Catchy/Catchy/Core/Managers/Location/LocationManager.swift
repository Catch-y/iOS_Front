//
//  MapViewModel.swift
//  Catchy
//
//  Created by euijjang97 on 12/15/25.
//

import Foundation
import Combine
import CoreLocation

@Observable
final class LocationManager: NSObject {
    // MARK: - State
    var currentLocation: CLLocationCoordinate2D?
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    var isAuthorized: Bool = false
    var locationError: Error?
    
    // MARK: - Geofencing State
    var activeGeofencedId: String?
    var isInsideGeofence: Bool = false
    var geofenceEvent: GeofenceEvent?
    
    // MARK: - Private
    private let manager = CLLocationManager()
    private var locationContinuation: CheckedContinuation<CLLocationCoordinate2D, Error>?
    private var monitor: CLMonitor?
    private var monitorTask: Task<Void, Never>?
    
    // MARK: - Constants
    static let geofenceRadius: CLLocationDistance = 100
    private let monitorName = "CatchyGeofenceMonitor"
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        updateAuthorizationStatus(manager.authorizationStatus)
    }
    
    deinit {
        monitorTask?.cancel()
    }
    
    // MARK: - Public
    /// 위치 권환 요청
    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    /// 위치 업데이트 시작
    func startUpdating() {
        guard isAuthorized else {
            requestAuthorization()
            return
        }
        manager.startUpdatingLocation()
    }
    
    /// 위치 업데이트 중지
    func stopUpdating() {
        manager.stopUpdatingLocation()
    }
    
    /// 현재 위치 한 번 요청
    func requestCurrentLocation() async throws -> CLLocationCoordinate2D {
        guard isAuthorized else {
            requestAuthorization()
            throw LocationError.notAuthoried
        }
        
        if let location = currentLocation {
            return location
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            locationContinuation = continuation
            manager.requestLocation()
        }
    }
    
    // MARK: - Geofencing Methods
    func startGeofenceMonitoring(
        at coordinate: CLLocationCoordinate2D,
        identifier: String,
        radius: CLLocationDistance = geofenceRadius
    ) async {
        await stopAllGeofenceMonitoring()
        monitor = await CLMonitor(monitorName)
        
        let condition = CLMonitor.CircularGeographicCondition(center: coordinate, radius: radius)
        
        await monitor?.add(condition, identifier: identifier, assuming: .unsatisfied)
        activeGeofencedId = identifier
        
        checkCurrentLocationInGeofence(center: coordinate, radius: radius)
        
        startMonitoringEvents()
    }
    
    func stopGeofenceMonitoring(withIdentifier identifier: String) async {
        await monitor?.remove(identifier)
        if activeGeofencedId == identifier {
            activeGeofencedId = nil
            isInsideGeofence = false
        }
    }
    
    func stopAllGeofenceMonitoring() async {
        monitorTask?.cancel()
        monitorTask = nil
        
        if let monitor = monitor {
            for identifier in await monitor.identifiers {
                await monitor.remove(identifier)
            }
        }
        
        activeGeofencedId = nil
        isInsideGeofence = false
        geofenceEvent = nil
    }
    
    func distance(to coordinate: CLLocationCoordinate2D) -> CLLocationDistance? {
        guard let current = currentLocation else { return nil }
        
        let currenLoc = CLLocation(latitude: current.latitude, longitude: current.longitude)
        let targetLoc = CLLocation(latitude: current.latitude, longitude: current.longitude)
        
        return currenLoc.distance(from: targetLoc)
    }
    
    // MARK: - Private Methods
    private func updateAuthorizationStatus(_ status: CLAuthorizationStatus) {
        authorizationStatus = status
        isAuthorized = (status == .authorizedWhenInUse || status == .authorizedAlways)
    }
    
    private func checkCurrentLocationInGeofence(center: CLLocationCoordinate2D, radius:
                                                CLLocationDistance) {
        guard let location = currentLocation else { return }
        
        let currentLoc = CLLocation(latitude: location.latitude, longitude:
                                        location.longitude)
        let centerLoc = CLLocation(latitude: center.latitude, longitude: center.longitude)
        let distance = currentLoc.distance(from: centerLoc)
        
        isInsideGeofence = distance <= radius
    }
    
    private func startMonitoringEvents() {
        monitorTask?.cancel()
        
        monitorTask = Task { [weak self] in
            guard let  self = self, let monitor = self.monitor else { return }
            
            do {
                for try await event in await monitor.events {
                    await MainActor.run {
                        self.handleMonitorEvent(event)
                    }
                }
            } catch {
                print("모니터링 에러: \(error.localizedDescription)")
            }
        }
    }
    
    @MainActor
    private func handleMonitorEvent(_ event: CLMonitor.Event) {
        switch event.state {
        case .satisfied:
            isInsideGeofence = true
            geofenceEvent = .entered(event.identifier)
        case .unsatisfied:
            isInsideGeofence = false
            geofenceEvent = .exited(event.identifier)
        case .unknown:
            break
        case .unmonitored:
            if activeGeofencedId == event.identifier {
                isInsideGeofence = false
                activeGeofencedId = nil
                geofenceEvent = nil
            }
        @unknown default:
            break
        }
    }
    
    private func updateGeofenceStatus() {
        guard let current = currentLocation,
              let _ = activeGeofencedId else { return }
        
        Task {
            guard let monitor = monitor else { return }
            
            for identifier in await monitor.identifiers {
                guard let record = await monitor.record(for: identifier) else { continue }
                
                if let condition = record.condition as?
                    CLMonitor.CircularGeographicCondition {
                    let currentLoc = CLLocation(latitude: current.latitude, longitude:
                                                    current.longitude)
                    let centerLoc = CLLocation(latitude: condition.center.latitude,
                                               longitude: condition.center.longitude)
                    let distance = currentLoc.distance(from: centerLoc)
                    
                    await MainActor.run {
                        self.isInsideGeofence = distance <= condition.radius
                    }
                }
            }
        }
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location.coordinate
        
        if let continuation = locationContinuation {
            locationContinuation = nil
            continuation.resume(returning: location.coordinate)
        }
        
        updateGeofenceStatus()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        locationError = error
        
        if let continuation = locationContinuation {
            locationContinuation = nil
            continuation.resume(throwing: LocationError.locationFailed(error.localizedDescription))
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        updateAuthorizationStatus(manager.authorizationStatus)
        
        if isAuthorized {
            manager.startUpdatingLocation()
        }
    }
}
