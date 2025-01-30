//
//  ReviewRequest.swift
//  Catchy
//
//  Created by 권용빈 on 1/25/25.
//

import Foundation

struct GetReviewRequest: Codable {
    let placeId: Int
    let page: Int
}
