//
//  RouteSegment.swift
//  Catchy
//
//  Created by euijjang97 on 12/15/25.
//

import Foundation
import MapKit

struct RouteSegment: Identifiable, Equatable {
    let id: UUID = .init()
    let polyline: MKPolyline
    let distance: Double
    let expectedTravelTime: Double
    
    let fromPlace: PlaceInfo
    let toPlace: PlaceInfo
    
    let segmentIndex: Int
    
    // MARK: - Equtable
    static func == (lhs: RouteSegment, rhs: RouteSegment) -> Bool {
        lhs.id == rhs.id
    }
}
