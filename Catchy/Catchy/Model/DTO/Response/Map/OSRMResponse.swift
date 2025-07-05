//
//  OSRMRequest.swift
//  Catchy
//
//  Created by 정의찬 on 2/19/25.
//

import Foundation

// MARK: - OSRMResult
import Foundation

// MARK: - Response
struct OSRMResponse: Codable {
    let code: String
    let routes: [Route]
}

// MARK: - Route
struct Route: Codable {
    let geometry: Geometry
    let legs: [Leg]
    let distance: Double
    let duration: Double
    let weight: Double
}

// MARK: - Geometry
struct Geometry: Codable {
    let coordinates: [[Double]]
    let type: String
}

// MARK: - Leg
struct Leg: Codable {
    let steps: [Step]
    let distance: Double
    let duration: Double
    let summary: String
}

// MARK: - Step
struct Step: Codable {
    let intersections: [Intersection]
    let drivingSide: String
    let geometry: Geometry
    let mode: String
    let duration: Double
    let maneuver: Maneuver
    let weight: Double
    let distance: Double
    let name: String

    enum CodingKeys: String, CodingKey {
        case intersections, geometry, mode, duration, maneuver, weight, distance, name
        case drivingSide = "driving_side"
    }
}

// MARK: - Intersection
struct Intersection: Codable {
    let out: Int?
    let location: [Double]
    let bearings: [Int]
    let entry: [Bool]
    let `in`: Int?
}

// MARK: - Maneuver
struct Maneuver: Codable {
    let bearingAfter: Int
    let type: String
    let modifier: String?
    let bearingBefore: Int
    let location: [Double]

    enum CodingKeys: String, CodingKey {
        case bearingAfter = "bearing_after"
        case type, modifier
        case bearingBefore = "bearing_before"
        case location
    }
}

// MARK: - Waypoint
struct Waypoint: Codable {
    let hint: String
    let location: [Double]
    let name: String
}
