//
//  PlaceInfoData.swift
//  Catchy
//
//  Created by 정의찬 on 2/19/25.
//

import Foundation
import MapKit
import SwiftUI

struct PlaceInfoData: Codable, Identifiable {
    
    var id = UUID()
    
    /// 장소 ID
    let placeId: Int
    
    /// 장소 이름
    let placeName: String
    
    /// 장소 위도
    let placeLatitude: Double
    
    /// 장소 경도
    let placeLongitude: Double
    
    /// 장소 카테고리
    let category: CategoryType
    
    /// 방문한 장소인가?
    let isVisited: Bool
    
    enum CodingKeys: String, CodingKey {
        case placeId
        case placeName
        case placeLatitude
        case placeLongitude
        case category
        case isVisited
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: placeLatitude, longitude: placeLongitude)
    }
}
