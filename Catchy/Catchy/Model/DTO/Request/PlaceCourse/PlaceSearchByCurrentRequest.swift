//
//  PlaceSearchByCurrentRequest.swift
//  Catchy
//
//  Created by LEE on 2/1/25.
//

import Foundation

/// 내 위치 기반 장소 검색 API
struct PlaceSearchByCurrentRequest: Codable {
    
    /// 검색어
    let searchKeyword: String
    
    /// 요청하는 페이지
    let page: Int
    
    /// 유저 위도
    let latitude: Double
    
    /// 유저 경도
    let longitude: Double
}
