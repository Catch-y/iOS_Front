//
//  DistrictResponse.swift
//  Catchy
//
//  Created by 정의찬 on 2/1/25.
//

import Foundation

struct DistrictResponse: Codable {
    let id: String
    let result: [District]
}

struct District: Codable {
    let cd: String        // 코드 (11, 21, 22 등)
    let addrName: String  // 시/도 이름
    let fullAddr: String  // 전체 주소
    let xCoor: String     // X 좌표
    let yCoor: String     // Y 좌표

    enum CodingKeys: String, CodingKey {
        case cd
        case addrName = "addr_name"
        case fullAddr = "full_addr"
        case xCoor = "x_coor"
        case yCoor = "y_coor"
    }
}
