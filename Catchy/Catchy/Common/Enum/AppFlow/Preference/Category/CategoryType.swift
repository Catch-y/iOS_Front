//
//  CategoryType.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import Foundation
import SwiftUI
import UIKit

/// 캐치 앱 카테고리 Enum
enum CategoryType: String, Codable, CaseIterable {
    case CAFE = "카페"
    case BAR = "주류"
    case RESTAURANT = "음식점"
    case EXPERIENCE = "체험"
    case CULTURELIFE = "문화생활"
    case SPORT = "스포츠"
    case REST = "휴식"
    
    // 영어 & 한글 모두 매핑
    private static let mapping: [String: CategoryType] = [
        "CAFE": .CAFE, "카페": .CAFE,
        "BAR": .BAR, "주류": .BAR,
        "RESTAURANT": .RESTAURANT, "음식점": .RESTAURANT,
        "EXPERIENCE": .EXPERIENCE, "체험": .EXPERIENCE,
        "CULTURELIFE": .CULTURELIFE, "문화생활": .CULTURELIFE,
        "SPORT": .SPORT, "스포츠": .SPORT,
        "REST": .REST, "휴식": .REST
    ]
    
    // JSON 디코딩 시 한글/영어 모두 지원
    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        if let category = CategoryType.mapping[rawValue] {
            self = category
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "지원되지 않는 카테고리 값: \(rawValue)")
        }
    }

    // JSON 인코딩 시 영어로 변환 (기본값)
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }
    
    /// 소 카테고리 작성
    var subcategories: [String] {
        switch self {
        case .CAFE:
            return ["프렌차이즈", "커피 전문점", "베이커리", "애견카페", "보드게임카페"]
        case .BAR:
            return ["요리 주점", "호프집", "바", "와인"]
        case .RESTAURANT:
            return ["한식", "분식", "중식", "일식", "양식", "동남아 음식", "멕시코 음식", "인도 음식", "고기 전문점", "해산물", "비건", "패스트푸드"]
        case .EXPERIENCE:
            return ["놀이공원", "VR/방탈출", "공방"]
        case .CULTURELIFE:
            return ["전시회", "영화관", "공연", "쇼핑", "책", "페스티벌"]
        case .SPORT:
            return ["축구", "농구", "야구", "탁구", "배구", "골프", "사격", "양궁"]
        case .REST:
            return ["캠핑", "공원", "테라피", "마사지"]
        }
    }
    
    /// 카테고리 별 이미지 리턴
    var categoryImage: ImageResource {
        switch self {
        case .CAFE:
            return .cafe
        case .BAR:
            return .bar
        case .RESTAURANT:
            return .restaurant
        case .EXPERIENCE:
            return .experience
        case .CULTURELIFE:
            return .cultureLife
        case .SPORT:
            return .sport
        case .REST:
            return .breaks
        }
    }
    
    /// 카테고리 별 배경 이미지 리턴
    var categoryBgImage: ImageResource {
        switch self {
        case .CAFE:
            return .cafeBackground
        case .BAR:
            return .barBackground
        case .RESTAURANT:
            return .retaurantBackground
        case .EXPERIENCE:
            return .experienceBackground
        case .CULTURELIFE:
            return .cultureLifeBackground
        case .SPORT:
            return .sportBackground
        case .REST:
            return .restBackground
        }
    }
    
    /// 카테고리 별 텍스트 리턴
    var categoryDescription: String {
        switch self {
        case .CAFE:
            return "커피나 음료, 차를 즐기며 여유로운 시간을 보낼 수 있는 장소를 추천드립니다."
        case .BAR:
            return "커피나 음료, 차를 즐기며 여유로운 시간을 보낼 수 있는 장소를 추천드립니다."
        case .RESTAURANT:
            return "다양한 요리와 맛을 즐길 수 있는 음식점을 추천드립니다."
        case .EXPERIENCE:
            return "특별한 경험과 즐거움을 만끽할 수 있는 다양한 체험 장소를 추천드립니다."
        case .CULTURELIFE:
            return "여가를 풍요롭게 채워줄 문화생활 공간을 추천드립니다."
        case .SPORT:
            return "다양한 스포츠를 즐기며 활력을 채울 수 있는 장소를 추천드립니다."
        case .REST:
            return "몸과 마음의 힐링을 위한 휴식과 웰니스 공간을 추천드립니다."
        }
    }
    
    /// 카테고리 별 배경색 리턴
    var categoryBgColor: Color {
        switch self {
        case .BAR:
            return Color.bar
        case .CAFE :
            return Color.cafe
        case .CULTURELIFE:
            return Color.culturaLife
        case .EXPERIENCE :
            return Color.experience
        case .REST :
            return Color.rest
        case .RESTAURANT :
            return Color.restaurant
        case .SPORT :
            return Color.sport
        }
    }
    
    func mapMarkerImage(isVisited: Bool) -> ImageResource {
        switch self {
        case .CAFE:
            return isVisited ? .notClickCafeMark : .clickCafeMark
        case .BAR:
            return isVisited ? .notClickBarMark : .clickBarMark
        case .RESTAURANT:
            return isVisited ? .notClickRestaurantMark : .clickRestaurantMark
        case .EXPERIENCE:
            return isVisited ? .notClickExperienceMark : .clickExperienceMark
        case .CULTURELIFE:
            return isVisited ? .notClickCultureLifeMark : .clickCultureLifeMark
        case .SPORT:
            return isVisited ? .notClickSportMark : .clickSportMark
        case .REST:
            return isVisited ? .notClickRestMark : .clickRestMark
        }
    }
    
    var voteImage: ImageResource {
        switch self {
        case .CAFE:
            return .voteCafe
        case .BAR:
            return .voteBar
        case .RESTAURANT:
            return .voteRestaurant
        case .EXPERIENCE:
            return .voteExperience
        case .CULTURELIFE:
            return .voteCultureLife
        case .SPORT:
            return .voteSport
        case .REST:
            return .voteBreaks
        }
    }
}
