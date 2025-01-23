//
//  AuthService.swift
//  Catchy
//
//  Created by 정의찬 on 1/22/25.
//

import Foundation
import Combine
import CombineMoya
import Moya
import SwiftUI

protocol AuthUseCaseProtocol {
    func executeSocialLogin(socialLoginType: SocialLoginType, socialToken: String) -> AnyPublisher<ResponseData<SocialLoginResponse>, MoyaError>
    
    func executeSignup(socialSignup: SocialLoginType, signupRequest: SignupRequest, image: UIImage) -> AnyPublisher<ResponseData<SocialLoginResponse>, MoyaError>
}
