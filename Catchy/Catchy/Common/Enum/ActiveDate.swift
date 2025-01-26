//
//  ActiveDate.swift
//  Catchy
//
//  Created by 정의찬 on 1/26/25.
//

import Foundation

enum ActiveDate: String, CaseIterable {
    case monDay = "MONDAY"
    case tuesDay = "TUESDAY"
    case wednesDay = "WEDNESDAY"
    case thursDay = "THURSDAY"
    case friday = "FRIDAY"
    case saturDay = "SATURDAY"
    case sunDay = "SUNDAY"
    
    func toKorean() -> String {
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
