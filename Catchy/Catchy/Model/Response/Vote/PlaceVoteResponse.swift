//
//  PlaceVoteResponse.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation

/// [장소 투표/취소] Response 모델
struct PlaceVoteResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: String
}
