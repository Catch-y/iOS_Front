//
//  PlaceVisitResponse.swift
//  Catchy
//
//  Created by LEE on 2/1/25.
//

import Foundation

/// 장소 방문체크 API
struct PlaceVisitResponse: Codable {
 
    /// 장소 방문 ID
    let placeVisitId: Int
    
    /// 장소 방문 ID
    let placeVisitId: Int
    
    /// 장소 방문 날짜
    let visitedDate: String
    
    /// 장소 방문 여부
    let isVisited: Bool
    
}
