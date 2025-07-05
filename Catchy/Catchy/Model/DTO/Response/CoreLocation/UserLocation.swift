//
//  UserLocation.swift
//  Catchy
//
//  Created by 정의찬 on 2/11/25.
//

import Foundation

/// 사용자 위도 경도 측정 데이터
struct UserLocation: Codable {
    let latitude: Double
    let longitude: Double
}
