//
//  LocationError.swift
//  Catchy
//
//  Created by euijjang97 on 12/15/25.
//

import Foundation

enum LocationError: LocalizedError {
    case notAuthoried
    case locationFailed(String)
    case timeout
    
    var errorDescription: String? {
        switch self {
        case .notAuthoried:
            return "위치 권한이 필요합니다."
        case .locationFailed(let message):
            return "위치를 가져올 수 없습니다. \(message)"
        case .timeout:
            return "위치 요청 시간이 초과되었습니다."
        }
    }
}
