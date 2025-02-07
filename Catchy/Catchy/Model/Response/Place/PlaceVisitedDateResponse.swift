//
//  PlaceVisitedDateResponse.swift
//  Catchy
//
//  Created by LEE on 2/7/25.
//

import Foundation

/// 장소 방문 날짜 리스트 조회 API
struct PlaceVisitedDateResponse: Codable {
    
    /// 방문 날짜 리스트
    let visitedDate: [String]
    
}

