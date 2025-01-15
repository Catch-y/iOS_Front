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
    
    //MARK: - Home
    case topLogo = "topLogo"
    case heart = "heart"
    case empyHeart = "empyHeart"
    case location = "location"
    case star = "star"
    case time = "time"
    
    var image: Image {
        return Image(self.rawValue)
    }
}
