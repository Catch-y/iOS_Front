//
//  GroupLeaveRequest.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation

/// [그룹 탈퇴] Request 모델
struct GroupLeaveRequest: Codable {
    let groupId: Int
    
    enum CodingKeys: String, CodingKey {
        case groupId
    }
}
