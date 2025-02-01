//
//  MyGroupsResponse.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation

/// [사용자가 속한 그룹 조회] Response 모델
struct GroupCalendarResponse: Codable {
    let groupId: Int
    let groupName: String
    let promiseTime: String
}

struct SortObject: Codable {
    let empty: Bool
    let unsorted: Bool
    let sorted: Bool
}

struct PageableObject: Codable {
    let offset: Int
    let sort: SortObject
    let unpaged: Bool
    let paged: Bool
    let pageNumber: Int
    let pageSize: Int
}

struct SliceGroupCalendarResponse: Codable {
    let size: Int
    let content: [GroupCalendarResponse]
    let number: Int
    let sort: SortObject
    let numberOfElements: Int
    let pageable: PageableObject
    let first: Bool
    let last: Bool
    let empty: Bool
}

/// BaseResponse 포함
struct BaseResponseSliceGroupCalendarResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: SliceGroupCalendarResponse
}
