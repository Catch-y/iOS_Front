//
//  GroupLeaveResponse.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation

/// [그룹 탈퇴] Response 모델
struct GroupLeaveResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [String: String] // Empty object in API response
    
    enum CodingKeys: String, CodingKey {
        case isSuccess, code, message, result
    }
}
