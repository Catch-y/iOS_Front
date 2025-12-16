//
//  RouteInfo.swift
//  Catchy
//
//  Created by euijjang97 on 12/16/25.
//

import Foundation
import MapKit

struct RouteInfo {
    let totalDistance: Int
    let toalTime: Int
    let totalSteps: Int
    let polylineCoordinates: [CLLocationCoordinate2D]
}
