//
//  TmapRouteDTO.swift
//  Catchy
//
//  Created by euijjang97 on 12/16/25.
//

import Foundation
import CoreLocation

// MARK: - Request
struct TMapRouteRequest: Codable {
    // 필수 값
    let startX: Double
    let startY: Double
    let endX: Double
    let endY: Double
    let startName: String
    let endName: String
    var passList: String?
    
    // 기타 옵션
    var reqCoordType: String = "WGS84GEO"
    var resCoordType: String = "WGS84GEO"
    var searchOption: Int = 0
    
    init(
        startX: Double, startY: Double,
        endX: Double, endY: Double,
        startName: String, endName: String,
        passPoints: [(lon: Double, lat: Double)]? = nil
    ) {
        self.startX = startX
        self.startY = startY
        self.endX = endX
        self.endY = endY
        
        self.startName = startName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? startName
        self.endName = endName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? endName
        
        if let points = passPoints, !points.isEmpty {
            let passString = points.map { "\($0.lon),\($0.lat)" }.joined(separator: "_")
            self.passList = passString
        } else {
            self.passList = nil
        }
    }
}

// MARK: - TMap Route Response
struct TMapRouteResponse: Codable {
    let type: String
    let features: [TMapFeature]
}

// MARK: - Feature
struct TMapFeature: Codable, Identifiable {
    let id = UUID()
    let type: String
    let geometry: TMapGeometry
    let properties: TMapProperties
    
    private enum CodingKeys: String, CodingKey {
        case type, geometry, properties
    }
}

// MARK: - Geometry (Enum으로 다형성 처리)
enum TMapGeometry: Codable {
    case point([Double])
    case lineString([[Double]])
    
    private enum CodingKeys: String, CodingKey {
        case type, coordinates
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case "Point":
            let coordinates = try container.decode([Double].self, forKey: .coordinates)
            self = .point(coordinates)
        case "LineString":
            let coordinates = try container.decode([[Double]].self, forKey: .coordinates)
            self = .lineString(coordinates)
        default:
            throw DecodingError.dataCorruptedError(
                forKey: .type,
                in: container,
                debugDescription: "Unknown geometry type: \(type)"
            )
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .point(let coordinates):
            try container.encode("Point", forKey: .type)
            try container.encode(coordinates, forKey: .coordinates)
        case .lineString(let coordinates):
            try container.encode("LineString", forKey: .type)
            try container.encode(coordinates, forKey: .coordinates)
        }
    }
}

// MARK: - Properties
struct TMapProperties: Codable {
    // 공통 및 Point 관련
    let index: Int
    let name: String?
    let description: String?
    let pointIndex: Int?
    let totalDistance: Int?
    let totalTime: Int?
    let direction: String?
    let nearPoiName: String?
    let nearPoiX: String?
    let nearPoiY: String?
    let intersectionName: String?
    let facilityType: String?
    let facilityName: String?
    let turnType: Int?
    let pointType: String? // "SP"(Start), "EP"(End), "GP"(General)
    let lineIndex: Int?
    let distance: Int?
    let time: Int?
    let roadType: Int?
    let categoryRoadType: Int?
}

extension TMapGeometry {
    // Point 좌표 반환
    var coordinate: CLLocationCoordinate2D? {
        if case .point(let coords) = self, coords.count >= 2 {
            return CLLocationCoordinate2D(latitude: coords[1], longitude: coords[0])
        }
        return nil
    }
    
    // LineString 경로 좌표 배열 반환
    var pathCoordinates: [CLLocationCoordinate2D] {
        if case .lineString(let coordsList) = self {
            return coordsList.compactMap { coord -> CLLocationCoordinate2D? in
                guard coord.count >= 2 else { return nil }
                return CLLocationCoordinate2D(latitude: coord[1], longitude: coord[0])
            }
        }
        return []
    }
}
