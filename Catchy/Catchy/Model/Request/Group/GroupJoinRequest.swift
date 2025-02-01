//
//  GroupJoinRequest.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation

/// [그룹 초대 코드로 가입] Request 모델
struct GroupJoinRequest: Codable {
    let inviteCode: String
    
    /// CodingKeys 정의 (필요 시 사용)
    enum CodingKeys: String, CodingKey {
        case inviteCode
    }
}
