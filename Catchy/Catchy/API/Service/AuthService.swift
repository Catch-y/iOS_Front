//
//  SwiftAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation
import Moya
import CombineMoya
import Combine
import SwiftUI

class AuthService: AuthServiceProtocol {
    private let provider: MoyaProvider<AuthAPITarget>
    
    init(provider: MoyaProvider<AuthAPITarget> = APIManager.shared.createProvider(for: AuthAPITarget.self)) {
        self.provider = provider
    }
    
    func signup(socialSignup: SocialLoginType, signupRequest: SignupRequest, image: UIImage) -> AnyPublisher<ResponseData<SocialLoginResponse>, MoyaError> {
        return provider.requestPublisher(.signup(socialSignup: socialSignup, signupRequest: signupRequest, image: image))
            .map(ResponseData<SocialLoginResponse>.self)
            .eraseToAnyPublisher()
    }
    
    func socialLogin(socialLoginType: SocialLoginType, socialToken: String) -> AnyPublisher<ResponseData<SocialLoginResponse>, MoyaError> {
        return provider.requestPublisher(.socialLogin(socialLoginType: socialLoginType, socialToken: socialToken))
            .map(ResponseData<SocialLoginResponse>.self)
            .eraseToAnyPublisher()
    }
}
