//
//  RecommendPlaceResponse.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import Foundation

struct RecommendPlaceResponse: Codable {
    let placeId: Int
    let placeImage: String
    let placeName: String
    let subCategory: String
    var isLike: Bool
    let starPoint: Double
    let reviewCnt: Int
    let placeLocation: String
    let placeOperTime: String
}
