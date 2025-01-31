//
//  PlaceSearchRequest.swift
//  Catchy
//
//  Created by LEE on 1/27/25.
//

import Foundation

struct PlaceSearchRequest: Codable {
    
    /// 검색어
    let searchKeyword: String
    
    /// 요청하는 페이지
    let page: Int
}
