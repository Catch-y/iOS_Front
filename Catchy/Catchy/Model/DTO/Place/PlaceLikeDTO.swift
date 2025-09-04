//
//  PlaceLikeDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 장소 좋아요
struct PlaceLikeResponse: Codable {
    let placeLikeId: Int
    let liked: Bool
}
