//
//  PlaceVisitList.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 장소 방문 날짜 리스트 조회
struct PlaceVisitListPath: Codable {
    let courseId: Int
    let placeId: Int
}

struct PlaceVisitListResponse: Codable {
    let visitedDate: [String]
}
