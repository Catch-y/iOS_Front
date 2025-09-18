//
//  TokenError.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/18/25.
//

import Foundation

enum TokenError: LocalizedError {
    case missRefreshToken
    case refreshFailed
    
    var errorDescription: String? {
        switch self {
        case .missRefreshToken:
            return "UseSession or RefreshToken not found"
        case .refreshFailed:
            return "Token Refresh failed: isSuccess false"
        }
    }
}
