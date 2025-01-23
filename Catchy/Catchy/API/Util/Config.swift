//
//  Config.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation

enum Config {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist cannot be fount")
        }
        return dict
    }()
    
    static let baseURL: String = {
        guard let baseURL = Config.infoDictionary["BASE_URL"] as? String else {
            fatalError("BaseURL not found")
        }
        return baseURL
    }()
    
    static let kakaoKey: String = {
        guard let kakao = Config.infoDictionary["KAKAO_KEY"] as? String else {
            fatalError("KakaoKey not found")
        }
        return kakao
    }()
    
    static let consumerKey: String = {
        guard let consumerKey = Config.infoDictionary["CONSUMER_KEY"] as? String else {
            fatalError("consumerKey not found")
        }
        return consumerKey
    }()
    
    static let consumerSecretKey: String = {
        guard let consumerSecretKey = Config.infoDictionary["CONSUMER_SECRET"] as? String else {
            fatalError("consumerSecretKey not found")
        }
        return consumerSecretKey
    }()
    
    static let locationImageKey: String = {
        guard let locationImageKey = Config.infoDictionary["LOCATIONIMAGE_KEY"] as? String else {
            fatalError("KakaoKey")
        }
        return locationImageKey
    }()
}
