//
//  UserState.swift
//  Catchy
//
//  Created by 정의찬 on 1/13/25.
//

import Foundation

class UserState: ObservableObject {
    
    static let shared = UserState()
    
    private var userNickname: String
    private var userEmail: String
    private let loginType: SocialLoginType
    
    init(
        userNickname: String = "",
        userEmail: String = "",
        loginType: SocialLoginType = .none
    ) {
        self.userNickname = userNickname
        self.userEmail = userEmail
        self.loginType = loginType
    }
    
    public func setUserNickname(_ userNickname: String) {
        UserDefaults.standard.setValue(userNickname, forKey: "UserNickname")
    }
    
    public func getUserNickname() -> String {
        guard let userNickname = UserDefaults.standard.string(forKey: "UserNickname") else {
            return "닉네임 정보 없음"
        }
        
        return userNickname
    }
    
    public func setUserEmail(_ userEmail: String) {
        UserDefaults.standard.setValue(userEmail, forKey: "UserEmail")
    }
    
    public func getUserEmail() -> String {
        guard let userEmail = UserDefaults.standard.string(forKey: "UserEmail") else {
            return "이메일 정보 없음"
        }
        
        return userEmail
    }
    
    public func setLoginType(_ loginType: SocialLoginType) {
        UserDefaults.standard.setValue(loginType.rawValue, forKey: "UserLoginType")
    }
    
    public func getLoginType() -> SocialLoginType {
        if let loginTypeRawValue = UserDefaults.standard.string(forKey: "UserLoginType"),
           let loginType = SocialLoginType(rawValue: loginTypeRawValue) {
            return loginType
        }
        return .none
    }
    
    public func clearProfile() {
        self.userNickname = ""
        self.userEmail = ""
    }
}
