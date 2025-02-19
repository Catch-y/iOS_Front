//
//  VoteCategoryResponse.swift
//  Catchy
//
//  Created by 임소은 on 2/8/25.
//

import Foundation

struct VoteCategoryResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: EmptyResult?
}

struct EmptyResult: Codable { }
