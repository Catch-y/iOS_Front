//
//  ReviewDeleteDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

struct ReviewDeleteResponse: Codable {
    let reviewId: Int
    let reviewType: ReviewType
    let message: String
}
