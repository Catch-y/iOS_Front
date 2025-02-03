//
//  PlaceLikedResponse.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import Foundation

/// 장소 좋아요 API
struct PlaceLikedResponse: Codable {
    
    /// 장소 Id
    let placeVisitId: Int
    
    /// 좋아요
    let liked: Bool
}
