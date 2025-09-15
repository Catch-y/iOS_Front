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
    private let provider = MoyaProvider<AuthAPITarget>()
    
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
        
        provider.request(.sendRefreshToken(refreshToken: refreshToken)) { result in
            switch result {
            case .success(let response):
                if let jsonString = String(data: response.data, encoding: .utf8) {
                    print("응답 JSON: \(jsonString)")
                } else {
                    print("JSON 데이터를 문자열로 변환할 수 없습니다.")
                }
                
                do {
                    let tokenData = try JSONDecoder().decode(ResponseData<TokenResponse>.self, from: response.data)
                    if tokenData.isSuccess {
                        self.accessToken = tokenData.result?.accessToken
                        self.refreshToken = tokenData.result?.refreshToken
                        completion(self.accessToken, nil)
                    } else {
                        let error = NSError(domain: "example.com", code: -1, userInfo: [NSLocalizedDescriptionKey: "Token Refresh failed: isSuccess false"])
                        //
                        completion(nil, error)
                    }
                } catch {
                    print("디코딩 에러: \(error)")
                    completion(nil, error)
                }
                
            case .failure(let error):
                print("네트워크 에러 : \(error)")
                completion(nil, error)
            }
        }
    }
    
    
}
