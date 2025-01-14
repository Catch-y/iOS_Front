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
