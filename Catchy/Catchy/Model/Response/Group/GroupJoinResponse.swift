//
//  GroupJoinResponse.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation

/// [그룹 초대 코드로 가입] Response 모델
struct GroupJoinResponse: Codable {
    let success: Bool
    let message: String
}

/// BaseResponse 포함 (명세서 구조 기반)
struct BaseResponseGroupJoinResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: GroupJoinResponse
}
