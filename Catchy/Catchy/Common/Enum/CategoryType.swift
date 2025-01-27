//
//  CategoryType.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import Foundation
import SwiftUI

enum CategoryType: String, Codable, CaseIterable {
    case CAFE = "카페"
    case BAR = "주류"
    case RESTAURANT = "음식점"
    case EXPERIENCE = "체험"
    case CULTURELIFE = "문화생활"
    case SPORT = "스포츠"
    case REST = "휴식"
    
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
    
    func reeturnIcon() -> Image {
        switch self {
        case .CAFE:
            return Icon.cafe.image
        case .BAR:
            return Icon.bar.image
        case .RESTAURANT:
            return Icon.restaurant.image
        case .EXPERIENCE:
            return Icon.experience.image
        case .CULTURELIFE:
            return Icon.cultureLife.image
        case .SPORT:
            return Icon.sport.image
        case .REST:
            return Icon.breaks.image
        }
    }
    
    func returnBackground() -> Image {
        switch self {
        case .CAFE:
            return Icon.cafeBackground.image
        case .BAR:
            return Icon.barBackground.image
        case .RESTAURANT:
            return Icon.retaurantBackground.image
        case .EXPERIENCE:
            return Icon.experienceBackground.image
        case .CULTURELIFE:
            return Icon.cultureLifeBackground.image
        case .SPORT:
            return Icon.sportBackground.image
        case .REST:
            return Icon.restBackground.image
        }
    }
    
    func retrunCategoryDescrip() -> String {
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
    
    
    func setColor() -> Color {
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
}
