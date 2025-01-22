//
//  AppFlowViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 1/22/25.
//

import Foundation

class AppFlowViewModel: ObservableObject {
    private let tokenProvider: TokenProvider = TokenProvider()
    
    @Published var appState: AppState = .onBoarding
    
    public func stateAppFlow(completion: @escaping (Bool, Error?) -> Void) {
        tokenProvider.refreshToken { [weak self] accessToken, error in
            guard self != nil else { return }
            
            if let error = error {
                self?.appState = .login
                completion(false, error)
                print("등록된 유저 정보 없음: \(error)")
            }
            
            if accessToken != nil {
                self?.appState = .tabView
                print("유저 정보 존재하고, 만료 안된 사용자")
                completion(true, nil)
            } else {
                self?.appState = .login
                completion(false, nil)
            }
        }
    }
}
