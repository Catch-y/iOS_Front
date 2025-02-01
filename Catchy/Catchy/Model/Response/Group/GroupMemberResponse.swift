//
//  GroupMemberResponse.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation

/// [그룹 유저 조회] Response 모델
struct GroupMemberResponse: Codable {
    let memberId: Int
    let nickname: String
    let profileImage: String
}

/// BaseResponse 포함 (명세서 구조 기반)
struct BaseResponseListGroupMemberResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [GroupMemberResponse]
}
