//
//  OSRMRequest.swift
//  Catchy
//
//  Created by 정의찬 on 2/19/25.
//

import Foundation

struct OSRMRequest: Codable {
    let start: OSRMCoordinate
    let routes: [OSRMCoordinate]
    let end: OSRMCoordinate
}

struct OSRMCoordinate: Codable {
    let longitude: Double
    let latitude: Double
}
