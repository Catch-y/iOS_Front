//
//  PlaceCourseCurrentSearchDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 내 위치 기반 장소 검색
struct PlaceCourseCurrentSearchRequest: Codable {
    let searchKeyword: String
    let latitude: Double
    let longitude: Double
}
