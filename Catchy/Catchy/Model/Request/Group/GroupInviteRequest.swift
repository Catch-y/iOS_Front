//
//  GroupInviteRequest.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation

/// [초대 코드로 그룹 정보 조회] Request 모델
struct GroupInviteRequest: Codable {
    let inviteCode: String

    /// CodingKeys 정의 (필요 시 사용 가능)
    enum CodingKeys: String, CodingKey {
        case inviteCode
    }
}
