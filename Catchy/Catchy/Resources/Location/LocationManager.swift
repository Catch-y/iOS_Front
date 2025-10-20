//
//  LocationManager.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/18/25.
//

import Foundation
import CoreLocation

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    // MARK:  - CLLocationManager
    var locationManager = CLLocationManager()
    var currentLocaton: CLLocation?
    var currentHeading: CLHeading?
    
    var estimatedTime: TimeInterval = 0
    var distance: CLLocationDistance = 0
    var authorizationStatus: CLAuthorizationStatus = .authorizedAlways
    var onAuthorizationStatusChanged: ((CLAuthorizationStatus) -> Void)?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.startUpdatingLocation()
        self.startUpdatingHeading()
    }
    
    // MARK: - 권한 요청
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    // MARK: - 위치 추적
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func getCurrentLocation() -> CLLocation? {
        return locationManager.location
    }
    
    // MARK: - 방향 추적
    func startUpdatingHeading() {
        locationManager.startUpdatingHeading()
    }
    
    func stopUpdatingHeading() {
        locationManager.stopUpdatingHeading()
    }
    
    // MARK: - Significant Location Change
    func startMonitoringSignificantLocationChanges() {
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func stopMonitoringSignificantLocationChanges() {
        locationManager.stopMonitoringSignificantLocationChanges()
    }
}

extension LocationManager {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        onAuthorizationStatusChanged?(status)
        
        if status == .denied || status == .restricted {
            print("위치 권한 거부 및 제한")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        DispatchQueue.main.async {
            self.currentHeading = newHeading
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.currentLocaton = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("위치 측정 오류: \(error)")
    }
}
