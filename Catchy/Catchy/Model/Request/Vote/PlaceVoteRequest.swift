//
//  PlaceVoteRequest.swift
//  Catchy
//
//  Created by 임소은 on 2/14/25.
//

import Foundation

/// 장소 투표/취소 Request DTO
struct PlaceVoteRequest: Codable {
    /// 선택한 장소 ID
    let placeId: Int

    /// CodingKeys 추가
    enum CodingKeys: String, CodingKey {
        case placeId = "placeId"
    }
}
