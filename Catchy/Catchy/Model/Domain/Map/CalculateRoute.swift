//
//  CalculateRoute.swift
//  Catchy
//
//  Created by euijjang97 on 12/15/25.
//

import Foundation
import MapKit

struct CalculatedRoute: Equatable, Identifiable {
    let id: UUID = .init()
    let polyline: MKPolyline
    let distance: Double
    let expectedTravelTime: Double
    let transportType: CourseTransportType
    
    let fromPlace: PlaceInfo?
    let waypoints: [PlaceInfo]
    let toPlace: PlaceInfo?
    
    // MARK: -  Property
    var allPlaces: [PlaceInfo] {
        var places: [PlaceInfo] = .init()
        if let from = fromPlace { places.append(from) }
        places.append(contentsOf: waypoints)
        if let to = toPlace { places.append(to) }
        return places
    }
    
    var hasWayPoints: Bool {
        !waypoints.isEmpty
    }
    
    var placeCount: Int {
        allPlaces.count
    }
    
    // MARK: - Equtable
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    // MARK: - Convenience Init (경유지 없는 경우)
    /// 경유지 없는 경우 초기화
    /// - Parameters:
    ///   - polyline: 출발점과 도착점의 최단거리 선 표시
    ///   - distance: 거리 차이 표시(Double)
    ///   - expectedTravelTime: 도보 기준 총 거리 시간
    ///   - transportType: 도보/주행 선택
    ///   - fromPlace: 출발지
    ///   - toPlace: 도착지
    init(
        polyline: MKPolyline,
        distance: Double,
        expectedTravelTime: Double,
        transportType: CourseTransportType,
        fromPlace: PlaceInfo?,
        toPlace: PlaceInfo?
    ) {
        self.polyline = polyline
        self.distance = distance
        self.expectedTravelTime = expectedTravelTime
        self.transportType = transportType
        self.fromPlace = fromPlace
        self.toPlace = toPlace
        self.waypoints = []
    }
    
    // MARK: - Full Init (경유지 포함)
    /// 경유지 포함하는 경우 초기화
    /// - Parameters:
    ///   - polyline: 출발점과 도착점의 최단거리 선 표시
    ///   - distance: 거리 차이 표시(Double)
    ///   - expectedTravelTime: 도보 기준 총 거리 시간
    ///   - transportType: 도보/주행 선택
    ///   - fromPlace: 출발지
    ///   - waypoints: 경유지 한 개 이상
    ///   - toPlace: 도착지
    init(
        polyline: MKPolyline,
        distance: Double,
        expectedTravelTime: Double,
        transportType: CourseTransportType,
        fromPlace: PlaceInfo?,
        waypoints: [PlaceInfo],
        toPlace: PlaceInfo?
    ) {
        self.polyline = polyline
        self.distance = distance
        self.expectedTravelTime = expectedTravelTime
        self.transportType = transportType
        self.fromPlace = fromPlace
        self.toPlace = toPlace
        self.waypoints = waypoints
    }
}
