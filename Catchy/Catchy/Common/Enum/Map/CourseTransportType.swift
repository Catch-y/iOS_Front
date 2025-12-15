//
//  CourseTransportType.swift
//  Catchy
//
//  Created by euijjang97 on 12/15/25.
//

import Foundation
import MapKit
import CoreLocation

enum CourseTransportType: String, CaseIterable {
    case walking = "도보"
    case automobile = "자동차"
    
    var mkTransportType: MKDirectionsTransportType {
        switch self {
        case .walking:
            return .walking
        case .automobile:
            return .automobile
        }
    }
    
    var icon: String {
        switch self {
        case .walking: return "figure.walk"
        case .automobile: return "car.fill"
        }
    }
}
