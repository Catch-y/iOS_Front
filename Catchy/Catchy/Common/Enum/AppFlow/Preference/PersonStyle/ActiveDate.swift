//
//  ActiveDate.swift
//  Catchy
//
//  Created by 정의찬 on 1/26/25.
//

import Foundation

/// 활동 시간 Enum
enum ActiveDate: String, CaseIterable, Codable {
    case monDay = "MONDAY"
    case tuesDay = "TUESDAY"
    case wednesDay = "WEDNESDAY"
    case thursDay = "THURSDAY"
    case friday = "FRIDAY"
    case saturDay = "SATURDAY"
    case sunDay = "SUNDAY"
    
    var text: String {
        switch self {
        case .monDay:
            return "월"
        case .tuesDay:
            return "화"
        case .wednesDay:
            return "수"
        case .thursDay:
            return "목"
        case .friday:
            return "금"
        case .saturDay:
            return "토"
        case .sunDay:
            return "일"
        }
    }
}
