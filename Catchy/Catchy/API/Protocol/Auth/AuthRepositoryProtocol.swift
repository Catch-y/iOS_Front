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
    func socialLoginData(socialLoginType: SocialLoginType, socialToken: String) -> AnyPublisher<ResponseData<SocialLoginResponse>, MoyaError>
    
    func signupData(socialSignup: SocialLoginType, signupRequest: SignupRequest, image: UIImage) -> AnyPublisher<ResponseData<SocialLoginResponse>, MoyaError>
}
