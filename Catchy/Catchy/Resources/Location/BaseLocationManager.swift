//
//  BaseLocationManager.swift
//  Catchy
//
//  Created by 정의찬 on 2/12/25.
//

import Foundation
import CoreLocation

/// 앱의 위치 서비스를 관리
/// CoreLocation을 사용하여 현재 위치 사용 및 업데이트 권한 설정
class BaseLocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    static let shared = BaseLocationManager()
    
    /// 위치 정보 관리
    private let locationManager = CLLocationManager()
    
    /// 위치 권환 상태 변경 감지
    var onAuthorizationStatusChanged: ((CLAuthorizationStatus) -> Void)?
    
    /// 현재 위치 저장
    @Published var currentLocation: CLLocation?
    
    /// 예상 이동 시간 저장
    @Published var estimatedTime: TimeInterval = 0
    
    /// 현재 위치와 특정 목적지 사이의 거리
    @Published var distance: CLLocationDistance = 0
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    /// 위치 권한이 변경될 때 호출
    /// - Parameter manager: 위치 관리자 인스턴스
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        onAuthorizationStatusChanged?(status)
    }
    
    /// 위치 권한 요청 메서드
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    /// 위치 업데이트 시작
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    /// 위치 업데이트 중지
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    /// 현재 위치 반환
    /// - Returns: 현재 위치
    func getCurrentLocation() -> CLLocation? {
        return locationManager.location
    }
    
    /// 최신 위치 업데이트
    /// - Parameters:
    ///   - manager: 최신 위치 바로 업데이트
    ///   - locations: 최신 위치
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.currentLocation = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("위치 측정 오류: \(error)")
    }
    
    /// 위치 업데이트 비동기 처리
    /// - Parameter completion: 현재 위치 값
    func getCurrentUserLocation(completion: @escaping (CLLocation?) -> Void) {
        locationManager.requestLocation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            completion(self.currentLocation)
        })
    }
    
}
