//
//  SwiftAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//


import Foundation
import SwiftUI

enum Icon: String {
    
    //MARK: - Onboarding
    case logo = "logo"
    
    //MARK: - Logo
    case kakao = "kakao"
    case apple = "apple"
    case appIcon = "appIcon"
    
    //MARK: - SignUp
    case signupProfile = "signupProfile"
    
    //MARK: - ETC
    case leftChevron = "leftChevron"
    case close = "close"
    case search = "search"
    case bottomChevron = "bottomChevron"
    
    //MARK: - Home
    case topLogo = "topLogo"
    case heart = "heart"
    case empyHeart = "empyHeart"
    case location = "location"
    case star = "star"
    case time = "time"
    case review = "review"
    case rightChevron = "rightChevron"
    
    //MARK: - Course
    case courseAI = "courseAI"
    case courseDIY = "courseDIY"
    case downChevron = "downChevron"
    case check = "check"
    case smileSearch = "smileSearch"
    
    //MARK: - Category
    case breaks = "breaks"
    case cafe = "cafe"
    case cultureLife = "cultureLife"
    case experience = "experience"
    case restaurant = "restaurant"
    case sport = "sport"
    case bar = "bar"
    
    case barBackground = "barBackground"
    case cafeBackground = "cafeBackground"
    case cultureLifeBackground = "cultureLifeBackground"
    case experienceBackground = "experienceBackground"
    case restBackground = "restBackground"
    case retaurantBackground = "retaurantBackground"
    case sportBackground = "sportBackground"
    
    
    //MARK: - Perference
    case couple = "couple"
    case family = "family"
    case friends = "friends"
    case solo = "solo"
    
    var image: Image {
        return Image(self.rawValue)
    }
}
