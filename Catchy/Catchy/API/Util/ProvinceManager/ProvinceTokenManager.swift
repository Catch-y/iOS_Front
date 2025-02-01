//
//  ProvinceTokenManager.swift
//  Catchy
//
//  Created by 정의찬 on 2/1/25.
//

import Foundation

class TokenManager {
    static let shared = TokenManager()
    
    private init() {}

    var accessToken: String?
    var accessTimeout: TimeInterval?

    func saveToken(_ token: String, timeout: TimeInterval) {
        print("✅ Saving Access Token: \(token)")  // ✅ 저장 시점 로그 추가
        self.accessToken = token
        self.accessTimeout = Date().timeIntervalSince1970 + timeout
    }

    func isTokenValid() -> Bool {
        guard let timeout = accessTimeout else { return false }
        return Date().timeIntervalSince1970 < timeout
    }
}
