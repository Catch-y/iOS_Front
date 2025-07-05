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

protocol AuthRepositoryProtocol {
    /// 소설 로그인
    func socialLoginData(socialLoginType: SocialLoginType, socialToken: String) -> AnyPublisher<ResponseData<SocialLoginResponse>, MoyaError>
    
    /// 회원 가입
    func signupData(socialSignup: SocialLoginType, signupRequest: SignupRequest, image: UIImage) -> AnyPublisher<ResponseData<SocialLoginResponse>, MoyaError>
}
