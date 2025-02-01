//
//  ProvinceService.swift
//  Catchy
//
//  Created by 정의찬 on 2/1/25.
//

import Foundation
import Moya
import Combine

class ProvinceService {
    private let provider = MoyaProvider<ProvinceAPITarget>()
    private var cancellables = Set<AnyCancellable>()
    
    func requestWithToken<T: Decodable>(_ target: ProvinceAPITarget, responseType: T.Type) -> AnyPublisher<T, Error> {
        return fetchValidToken()
            .flatMap { token in
                self.provider.requestPublisher(target)
                    .tryMap { response -> Data in
                        if let jsonString = String(data: response.data, encoding: .utf8) {
                            print("📥 Raw JSON Response: \(jsonString)")
                        }
                        return response.data
                    }
                    .decode(type: T.self, decoder: JSONDecoder())
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func fetchValidToken() -> AnyPublisher<String, Error> {
        if TokenManager.shared.isTokenValid(), let token = TokenManager.shared.accessToken {
            print("✅ 캐시된 액세스 토큰: \(token)")
            return Just(token)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            print("🔄 액세스 토큰 갱신중...!")
            return fetchAccessToken()
                .map { tokenResponse in
                    TokenManager.shared.saveToken(tokenResponse.result.accessToken, timeout: 4 * 60 * 60)
                    return tokenResponse.result.accessToken
                }
                .eraseToAnyPublisher()
        }
    }
    
    func fetchAccessToken() -> AnyPublisher<ProvinceAccessTokenResponse, Error> {
        print("🔄 액세스 토큰 갱신 요청 시작..!")
        
        return provider.requestPublisher(.getAccessToken)
            .tryMap { response -> Data in
                if let jsonString = String(data: response.data, encoding: .utf8) {
                    print("📥 Raw Access Token Response: \(jsonString)")
                }
                return response.data
            }
            .decode(type: ProvinceAccessTokenResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
