//
//  MemberStyleTimeDTO.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/4/25.
//

import Foundation

/// 사용자 취향 설문 참여스타일
struct MemberStyleTimeRequest: Codable {
    let styleNames: [CompanionType]
    let activeTimes: [ActiveTime]
}

struct ActiveTime: Codable {
    let dayOfWeek: ActiveDate
    let startTime: String
    let endTime: String
}

struct MemeberStyleTimeResponse: Codable {
    let memberStyleSurveyId: [Int]
    let activeTimeSurveyId: [Int]
}
