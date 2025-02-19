//
//  GroupMyGroupsRequest.swift
//  Catchy
//
//  Created by 임소은 on 2/18/25.
//

import Foundation

/// 사용자가 속한 그룹을 조회하기 위한 요청 모델
struct GroupMyGroupsRequest: Encodable {
    let year: Int
    let month: Int
}
