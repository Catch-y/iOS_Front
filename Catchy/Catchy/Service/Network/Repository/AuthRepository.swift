//
//  SwiftAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation
import Combine
import CombineMoya
import Moya
import SwiftUI

class AuthRepository: AuthRepositoryProtocol {
    private let service: AuthServiceProtocol
    
    init(service: AuthServiceProtocol = AuthService()) {
        self.service = service
    }
    
    func signupData(socialSignup: SocialLoginType, signupRequest: SignupRequest, image: UIImage) -> AnyPublisher<ResponseData<SocialLoginResponse>, MoyaError> {
        return service.signup(socialSignup: socialSignup, signupRequest: signupRequest, image: image)
    }
    
    func socialLoginData(socialLoginType: SocialLoginType, socialToken: String) -> AnyPublisher<ResponseData<SocialLoginResponse>, MoyaError> {
        return service.socialLogin(socialLoginType: socialLoginType, socialToken: socialToken)
    }
}
