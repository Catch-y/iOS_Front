//
//  RouteError.swift
//  Catchy
//
//  Created by euijjang97 on 12/15/25.
//

import Foundation

enum RouteError: LocalizedError {
    case insufficientPlaces
    case noRouteFound
    case networkError(String)
    case locationNotAvailable
    case directionsError(String)
    
    var errorDescription: String? {
        switch self {
        case .insufficientPlaces:
            return "경로를 계산하려면 최소 2개의 장소가 필요합니다."
        case .noRouteFound:
            return "경로를 찾을 수 없습니다."
        case .networkError(let message):
            return "네트워크 오류 : \(message)"
        case .locationNotAvailable:
            return "현재 위치를 가져올 수 없습니다."
        case .directionsError(let message):
            return "경로 계산 오류 : \(message)"
        }
    }
}
