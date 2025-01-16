//
//  CourseDetailResponse.swift
//  Catchy
//
//  Created by 정의찬 on 1/16/25.
//

import Foundation

struct CourseDetailResponse: Codable {
    let courseId: Int
    let courseImage: String
    let courseName: String
    let courseDescription: String
    let courseType: CouseCreatedType
    let rating: Double
    let reviewCount: Int
    let recommendTime: String
    let participantsNumber: Int
    let isBookmark: Bool
    let placeInfos: [PlaceInfo]
}

struct PlaceInfo: Codable, Hashable, Identifiable {
    var id = UUID()
    var placeId: Int
    var placeName: String
    var placeLatitude: Double
    var placeLongitude: Double
    var isVisited: Bool
}
