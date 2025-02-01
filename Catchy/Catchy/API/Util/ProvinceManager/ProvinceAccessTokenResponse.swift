//
//  ProvinceAccessTokenResponse.swift
//  Catchy
//
//  Created by 정의찬 on 2/1/25.
//

import Foundation

struct ProvinceAccessTokenResponse: Codable {
    let id: String
    let result: ProvinceAccessResult
    let errMsg: String
    let errCd: Int
    let trId: String
}

struct ProvinceAccessResult: Codable {
    let accessTimeout: String
    let accessToken: String
}
