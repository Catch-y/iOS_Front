//
//  AppStorageKey.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/18/25.
//

import Foundation

enum AppStorageKey: CaseIterable {
    static let userFCMToken: String = "UserFCMToken"
    static let userNickname: String = "UserNickname"
    static let userEmail: String = "UserEmail"
    static let UserLoginType: String = "UserLoginType"
    static let UserNickname: String = "UserNickname"
    // TODO:  - 앱 삭제 후 재설치 시, AppStroagekey 채울 수 있도록 하기
}
