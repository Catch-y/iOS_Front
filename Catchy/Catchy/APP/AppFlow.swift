//
//  AppFlow.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/18/25.
//

import Foundation

@Observable
class AppFlow {
    private var appState: AppState = .onBoarding
    private var tokenProvider: TokenProvider
    private var seesionStore: SessionStoring
    
    init(
        tokenProvider: TokenProvider = TokenProvider(),
        sessionStore: SessionStoring = KeychainSessionStore()
    ) {
        self.tokenProvider = tokenProvider
        self.seesionStore = sessionStore
    }
    
    public func stateAppFlow(completion: @escaping (Bool, Error?) -> Void) {
        tokenProvider.refreshToken { [weak self] accessToken, error in
            guard let self = self else { return }
            
            if let error = error {
                self.appState = .login
                self.seesionStore.userInfo = nil
                completion(false, error)
                
                #if DEBUG
                print("등록된 유저 정보 없음: \(error)")
                #endif
            }
            
            if let _ = accessToken {
                self.appState = .tab
                
                #if DEBUG
                print("유저 정보 존재하고, 만료 안된 사용자")
                #endif
                
                completion(true, nil)
            } else {
                self.appState = .login
                completion(false, nil)
            }
        }
    }
    
    public func onLoginSuccess() {
        
    }
    
    public func onSignupSuccess() {
        appState = .preferrenceSurvey
    }
    
    public func changeTab() {
        appState = .tab
    }
}
