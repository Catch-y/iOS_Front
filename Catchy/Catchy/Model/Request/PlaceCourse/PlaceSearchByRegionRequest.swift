//
//  PlaceSearchByRegionRequest.swift
//  Catchy
//
//  Created by LEE on 1/27/25.
//

import Foundation

/// 지역명 기반 장소 검색 API
struct PlaceSearchByRegionRequest: Codable {
    
    /// 검색어
    let searchKeyword: String
    
    /// 요청하는 페이지
    let page: Int
}

