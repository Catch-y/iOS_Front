//
//  DistrictResponse.swift
//  Catchy
//
//  Created by 정의찬 on 2/1/25.
//

import Foundation

struct DistrictResponse: Codable {
    let cd: String
    let addrName: String
    let fullAddr: String
    let xCoor: String
    let yCoor: String
    
    enum CodingKeys: String, CodingKey {
        case cd, xCoor = "x_coor", yCoor = "y_coor", addrName = "addr_name", fullAddr = "full_addr"
    }
}
