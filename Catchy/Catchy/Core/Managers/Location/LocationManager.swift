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
    
    // MARK: - Private
    private let manager = CLLocationManager()
    private var locationContinuation: CheckedContinuation<CLLocationCoordinate2D, Error>?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        updateAuthorizationStatus(manager.authorizationStatus)
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
    
    
    // MARK: - Private Methods
    private func updateAuthorizationStatus(_ status: CLAuthorizationStatus) {
        authorizationStatus = status
        isAuthorized = (status == .authorizedWhenInUse || status == .authorizedAlways)
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
