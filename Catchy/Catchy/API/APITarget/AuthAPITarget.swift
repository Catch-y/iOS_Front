//
//  AuthAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation
import Moya
import SwiftUI

enum AuthAPITarget {
    case sendRefreshToken(refreshToken: String) // 리프레시 토큰 갱신
    case socialLogin(socialLoginType: SocialLoginType, socialToken: String) // 소셜 로그인 애플 및 카카오 처리
    case signup(socialSignup: SocialLoginType, signupRequest: SignupRequest, image: UIImage) // 회원가입 멀티파트폼
}

extension AuthAPITarget: APITargetType {
    var path: String {
        switch self {
        case .sendRefreshToken:
            return "/member/reissue"
        case .socialLogin(let socialLoginType, _):
            return "/member/login/\(socialLoginType.rawValue)"
        case .signup(let socialSignup, _, _):
            return "/member/signup/\(socialSignup.rawValue)"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .sendRefreshToken:
            return .get
        case .socialLogin, .signup:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .sendRefreshToken:
            return .requestPlain
        case .socialLogin(_, let token):
            return .requestParameters(parameters: ["accessToken": token], encoding: JSONEncoding.default)
        case .signup(_, let info, let image):
            let formData = encodeSignupData(signupRequest: info, profileImage: image)
            return .uploadMultipart(formData)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .sendRefreshToken(let refresh):
            var headers = ["Content-Type": "application/json"]
            headers["refreshToken"] = "Bearer \(refresh)"
            
            return headers
        case .signup:
            return ["Content-Type": "multipart/form-data"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
    
}

extension AuthAPITarget {
    private func encodeSignupData(signupRequest: SignupRequest, profileImage: UIImage) -> [MultipartFormData] {
        
        var formData: [MultipartFormData] = []
        
        if let jsonData = try? JSONEncoder().encode(signupRequest) {
            let infoData = MultipartFormData(provider: .data(jsonData), name: "info", fileName: "info.json",
                                             mimeType: "application/json")
            formData.append(infoData)
        }
        
        if let imageData = profileImage.jpegData(compressionQuality: 0.8) {
            let multipartData = MultipartFormData(provider: .data(imageData), name: "profileImage", fileName: "profileImage.jpg", mimeType: "profileImage/jpeg")
            formData.append(multipartData)
        }
        
        return formData
    }
}
