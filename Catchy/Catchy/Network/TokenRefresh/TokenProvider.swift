//
//  TokenProvider.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation
import Moya

class TokenProvider: TokenProviding {
    @KeychainStored private var userInfo: UserInfo?
    
    var accessToken: String? {
        get { userInfo?.accessToken }
        set {
            guard var user = userInfo else { return }
            user.accessToken = newValue
            userInfo = user
            
            #if DEBUG
            print("유저 액세스 토큰 갱신됨: \(String(describing: newValue))")
            #endif
        }
    }
    
    var refreshToken: String? {
        get { userInfo?.refreshToken }
        set {
            guard var user = userInfo else { return }
            user.refreshToken = newValue
            userInfo = user
            
            #if DEBUG
            print("유저 리프레시 갱신됨: \(String(describing: newValue))")
            #endif
        }
    }
    
    func refreshToken(completion: @escaping (String?, (any Error)?) -> Void) {
        guard let refreshToken = refreshToken else {
            let error = NSError(domain: "ttakkeun.com", code: -2, userInfo: [NSLocalizedDescriptionKey: "UserSession or refreshToken not found"])
            completion(nil, error)
            return
        }
    }
}
