//
//  HomeSectionType.swift
//  Catchy
//
//  Created by euijjang97 on 12/3/25.
//

import Foundation

enum HomeSectionType: CaseIterable, Identifiable {
    case courseCardSection
    case popularCourseCard
    case recommendPlaceCard
    
    var id: String {
        switch self {
        case .courseCardSection:
            return "courseCardSection"
        case .popularCourseCard:
            return "PopularCourseCard"
        case .recommendPlaceCard:
            return "RecommendPlaceCard"
        }
    }
    
    var isChevron: Bool {
        self == .recommendPlaceCard
    }
}
