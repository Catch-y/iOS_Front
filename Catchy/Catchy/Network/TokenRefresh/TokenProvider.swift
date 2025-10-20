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
    private let provider = MoyaProvider<MemberRouter>()
    
    
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
            return completion(nil, TokenError.missRefreshToken)
        }
        
        provider.request(.getTokenRefresh(token: refreshToken)) { [weak self] result in
            self?.tokenRefreshAction(result, completion: completion)
        }
    }
    
    private func tokenRefreshAction(
        _ result: Result<Response, MoyaError>,
        completion: @escaping (String?, Error?) -> Void
    ) {
        switch result {
        case .success(let success):
            successAction(success, completion: completion)
        case .failure(let failure):
            completion(nil, failure)
        }
    }
    
    private func successAction(_ success: Response, completion: @escaping (String?, Error?) -> Void) {
        do {
            let tokenData = try JSONDecoder().decode(ResponseData<MemberReIssueResponse>.self, from: success.data)
            guard tokenData.isSuccess, let result = tokenData.result else {
                return completion(nil, TokenError.refreshFailed)
            }
            
            self.accessToken = result.accessToken
            self.refreshToken = result.refreshToken
            
            completion(result.accessToken, nil)
        } catch {
            completion(nil, error)
        }
    }
}
