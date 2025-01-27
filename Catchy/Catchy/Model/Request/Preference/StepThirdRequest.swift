//
//  SteTowRequest.swift
//  Catchy
//
//  Created by 정의찬 on 1/26/25.
//

import Foundation

/// 취향 설문 조사 3, 4단계
struct StepThirdRequest: Codable {
    let styleNames: [CompanionType]
    let activeTimes: [ActiveDateDTO]
}

struct ActiveDateDTO: Codable {
    let dayOfWeek: ActiveDate
    let startTime: String
    let endTime: String
}
