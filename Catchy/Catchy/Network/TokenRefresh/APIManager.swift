//
//  APIManager.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation
import Moya

class APIManager: @unchecked Sendable {
    static let shared = APIManager()
    
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    
    private init() {
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProviding: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
    }
    
    public func createProvider<T: TargetType>(for targetType: T.Type) -> MoyaProvider<T> {
        let logger = NetworkLoggerPlugin(configuration: .init(
            logOptions: [.requestBody, .successResponseBody, .errorResponseBody, .formatRequestAscURL, .verbose]
        ))
        
        return MoyaProvider<T>(session: session, plugins: [logger])
    }
    
    public func testProvider<T: TargetType>(for targetType: T.Type) -> MoyaProvider<T> {
        return MoyaProvider<T>(stubClosure: MoyaProvider.immediatelyStub)
    }
    
    lazy var sharedDecoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .useDefaultKeys
        return d
    }()
}
