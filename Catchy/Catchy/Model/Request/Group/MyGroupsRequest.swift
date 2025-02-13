//
//  MyGroupsRequest.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation

/// [사용자가 속한 그룹 조회] Request 모델
struct MyGroupsRequest: Codable {
    let page: Int
    let size: Int
    
    /// CodingKeys 정의
    enum CodingKeys: String, CodingKey {
        case page
        case size
    }
}
