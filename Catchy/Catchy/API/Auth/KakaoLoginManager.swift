//
//  KakaoLoginManager.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import Foundation
import Alamofire
import KakaoSDKAuth
import KakaoSDKUser

class KakaoLoginManager {
    /// 카카오 액세스 토큰 조회 하기
    /// - Parameter completion: 카카오로부터 받은 액세스 토큰 가져오기
    func fectchAccessToken(completion: @escaping (Result<String, Error>) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    completion(.failure(error))
                } else if let oauthToken = oauthToken {
                    completion(.success(oauthToken.accessToken))
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    completion(.failure(error))
                } else if let oauthToken = oauthToken {
                    completion(.success(oauthToken.accessToken))
                }
            }
        }
    }
    
    /// 카카오 유저 이메일 가져오기
    /// - Parameter completion: 카카오로부터 받은 이메알 가져오기
    func getUserEmail(completion: @escaping (Result<String, Error>) -> Void) {
        UserApi.shared.me { user, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = user, let email = user.kakaoAccount?.email {
                completion(.success(email))
            }
        }
    }
}
