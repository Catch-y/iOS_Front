//
//  SignUpNaviData.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation



struct SignUpNaviData: Equatable, Hashable {

    let accessToken: String
    let authorizationCode: String?
    let email: String
    let loginType: SocialLoginType
}
