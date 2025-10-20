//
//  ResponseData.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation

struct ResponseData<T: Codable>: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: T?
}
