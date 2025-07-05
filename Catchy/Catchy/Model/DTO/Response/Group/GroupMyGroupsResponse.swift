//
//  GroupMyGroupsResponse.swift
//  Catchy
//
//  Created by 임소은 on 2/18/25.
//

import Foundation

/// 사용자가 속한 그룹 조회 응답 모델
struct GroupMyGroupsResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [GroupCalendarResponse]
}

/// 그룹 일정 응답 모델
struct GroupCalendarResponse: Codable {
    let groupId: Int
    let groupName: String
    let promiseTime: String
}
