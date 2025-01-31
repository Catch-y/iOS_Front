//
//  PlaceCategoryRegisterRequest.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation

/// 장소 카테고리 선택 API
struct PlaceCategoryRegisterRequest: Codable {
    
    /// 장소 ID
    let placeId: Int
    
    /// 장소 카테고리
    /// ex) 음식점, 문화생활
    let bigCategory: CategoryType
    
    /// 장소 소 카테고리
    /// ex) 일식, 중식
    // TODO: - 소 카테고리 타입 처리.
    let smallCategory: [String]
}
