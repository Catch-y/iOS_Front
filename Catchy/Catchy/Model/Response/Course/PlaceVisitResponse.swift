//
//  PlaceVisitResponse.swift
//  Catchy
//
//  Created by LEE on 2/1/25.
//

import Foundation

/// 장소 방문체크 API
// TODO: - 스웨거 작성
struct PlaceVisitResponse: Codable {
 
    /// 장소 방문 ID
    let placeVisitId: Int
    
    /// 장소 방문 날짜
    let visitedDate: String
    
    /// 방문했는가?
    let isVisited: Bool
}
