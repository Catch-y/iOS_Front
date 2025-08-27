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

class AuthUseCase: AuthUseCaseProtocol {
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol = AuthRepository()) {
        self.repository = repository
    }
    
    func executeSignup(socialSignup: SocialLoginType, signupRequest: SignupRequest, image: UIImage) -> AnyPublisher<ResponseData<SocialLoginResponse>, MoyaError> {
        return repository.signupData(socialSignup: socialSignup, signupRequest: signupRequest, image: image)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executeSocialLogin(socialLoginType: SocialLoginType, socialToken: String) -> AnyPublisher<ResponseData<SocialLoginResponse>, MoyaError> {
        return repository.socialLoginData(socialLoginType: socialLoginType, socialToken: socialToken)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
}
