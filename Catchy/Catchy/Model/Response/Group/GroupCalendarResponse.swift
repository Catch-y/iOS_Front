//
//  GroupCalendarResponse.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation

/// [사용자가 속한 그룹 목록]에서 개별 그룹 정보
struct GroupCalendarResponse: Codable {
    let groupId: Int
    let groupName: String
    let promiseTime: String?
}
