//
//  PlaceCourseDetailDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 장소 상세 화면
struct PlaceCourseDetailPath: Codable {
    let placeId: Int
}

struct PlaceCourseDetailResponse: Codable {
    let placeId: Int
    let imageUrl: String
    let placeName: String
    let placeDescription: String
    let categoryName: CategoryType
    let roadAddress: String
    let activeTime: String
    let placeSite: String
    let rating: Double
    let reviewCount: Int
    let placeLatitude: Double
    let placeLongitude: Double
    let liked: Bool
    let visited: Bool
}
