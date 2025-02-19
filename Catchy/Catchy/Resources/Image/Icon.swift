//
//  SwiftAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//


import Foundation
import SwiftUI

enum Icon: String {
    
    //MARK: - Tab
    case home = "home"
    case course = "course"
    case group = "group"
    case mypage = "mypage"
    
    //MARK: - Onboarding
    case logo = "logo"
    
    //MARK: - Logo
    case kakao = "kakao"
    case apple = "apple"
    case appIcon = "appIcon"
    
    //MARK: - SignUp
    case signupProfile = "signupProfile"
    case notCheckName = "notCheckName"
    case checkName = "checkName"
    
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
    case emptyStar = "emptyStar"
    case time = "time"
    case review = "review"
    case rightChevron = "rightChevron"
    case emptyResult = "emptyResult"
    
    //MARK: - Course
    case courseAI = "courseAI"
    case courseDIY = "courseDIY"
    case downChevron = "downChevron"
    case check = "check"
    case smileSearch = "smileSearch"
    case domain = "domain"

    case loading = "loading"
    case red_pin = "red_pin"
    case blue_pin = "blue_pin"
    case yellow_pin = "yellow_pin"
    case purple_pin = "purple_pin"

    case bookmark = "bookmark"
    case bookMarkTrue = "bookMarkTrue"
    case visitCheck = "visitCheck"
    case visitStamp = "visitStamp"
    case emptyStamp = "emptyStamp"
    case colorReview = "colorReview"
    case warningIntro = "warningIntro"
    
    case trash = "trash"
    
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
    
    //MARK: - MyPage
    case pencil = "pencil"
    case document = "document"
    case myPageHeart = "myPageHeart"
    case myPageReview = "myPageReview"
    case settingIcon = "settingIcon"
    //MARK: - Review
    case checkBtnSelected = "checkBtnSelected"
    case checkBtnUnselected = "checkBtnUnselected"
    
    //MARK: - Perference
    case couple = "couple"
    case family = "family"
    case friends = "friends"
    case solo = "solo"
    case allCheckBtn = "allCheckBtn"
    case allSelectCheckBtn = "allSelectCheckBtn"
    case provinceBtn = "provinceBtn"
    
    //MARK: - VoteCategory
    case voteBreaks = "voteBreaks"
    case voteCafe = "voteCafe"
    case voteCultureLife = "voteCultureLife"
    case voteExperience = "voteExperience"
    case voteRestaurant = "voteRestaurant"
    case voteSport = "voteSport"
    case voteBar = "voteBar"
    
    case voteStartButton = "voteStartButton"
    case circleHeart = "circleHeart"

    //MARK: - Group
    case plusGroup = "plusGroup"
    case minusMonth = "minusMonth"
    case plusMonth = "plusMonth"
    case qrcodeIcon = "qrcodeIcon"
    case shareButton = "shareButton"
    case downButton = "downButton"
    
    
    var image: Image {
        return Image(self.rawValue)
    }
}


