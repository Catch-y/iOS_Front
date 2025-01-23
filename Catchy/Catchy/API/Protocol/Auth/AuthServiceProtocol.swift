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
    func socialLogin(socialLoginType: SocialLoginType, socialToken: String) -> AnyPublisher<ResponseData<SocialLoginResponse>, MoyaError>
    
    func signup(socialSignup: SocialLoginType, signupRequest: SignupRequest, image: UIImage) -> AnyPublisher<ResponseData<SocialLoginResponse>, MoyaError>
}
