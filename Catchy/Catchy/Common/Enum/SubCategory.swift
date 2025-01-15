//
//  SubCategory.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import Foundation

/// 카페 소 카테고리
enum CafeSubCategory: String, SubCategoryProtocol {
    case franchise = "프렌차이즈"
    case coffeeSpcialty = "커피 전문점"
    case bakery = "베이커리"
    case petCafe = "애견카페"
    case boardGameCafe = "보드게임카페"
}

/// 주류 소 카테고리
enum AlcoholSubCategory: String, SubCategoryProtocol {
    case foodPub = "요리주점"
    case beerPub = "호프집"
    case bar = "바"
    case wine = "와인"
}

// 음식점 소 카테고리
enum RestaurantSubCategory: String, SubCategoryProtocol {
    case mexican = "멕시코 음식"
    case indian = "인도 음식"
    case meat = "고기 전문점"
    case seafood = "해산물"
    case vegan = "비건"
    case fastFood = "패스트푸드"
}

// 체험 소 카테고리
enum ExperienceSubCategory: String, SubCategoryProtocol {
    case amusementPark = "놀이공원"
    case vrEscapeRoom = "VR/방탈출"
    case workshop = "공방"
}

// 문화생활 소 카테고리
enum CultureSubCategory: String, SubCategoryProtocol {
    case exhibition = "전시회"
    case cinema = "영화관"
    case performance = "공연"
    case shopping = "쇼핑"
    case books = "책"
    case festival = "페스티벌"
}

// 스포츠 소 카테고리
enum SportsSubCategory: String, SubCategoryProtocol {
    case soccer = "축구"
    case basketball = "농구"
    case baseball = "야구"
    case tableTennis = "탁구"
    case volleyball = "배구"
    case golf = "골프"
    case shooting = "사격"
    case archery = "양궁"
}

// 휴식/웰니스 소 카테고리
enum WellnessSubCategory: String, SubCategoryProtocol {
    case camping = "캠핑"
    case park = "공원"
    case therapy = "테라피"
    case massage = "마사지"
}
