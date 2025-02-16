//
//  AuthService.swift
//  Catchy
//
//  Created by 정의찬 on 1/22/25.
//

import Foundation
import Combine
import Moya
import SwiftUI

protocol AuthServiceProtocol {
    /// 소셜 로그인
    func socialLogin(socialLoginType: SocialLoginType, socialToken: String) -> AnyPublisher<ResponseData<SocialLoginResponse>, MoyaError>
    
    /// 회원 가입
    func signup(socialSignup: SocialLoginType, signupRequest: SignupRequest, image: UIImage) -> AnyPublisher<ResponseData<SocialLoginResponse>, MoyaError>
}
