//
//  FCMTokenManager.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/18/25.
//

import Foundation
import Combine

class FCMTokenManager
{
    // MARK: - Property
    let container: DIContainer
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: - Init
    init(container: DIContainer) {
        self.container = container
    }
    
    // MARK: - Method
    /// 토큰 캐치 서버 전달
    /// - Parameter token: FCM 토큰 전달
    func sendUpdatedFcmToken(_ token: String) {
        container.useCaseProvider.memberUseCase.executePatchFCMToken(token: .init(fcmToken: token))
            .validateResult()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("patchFCMToken Completed")
                case .failure(let failure):
                    print("patchFCMToken Fialed: \(failure)")
                }
            },  receiveValue: { result in
                #if DEBUG
                print("FCMTOKEN: \(result)")
                #endif
            })
            .store(in: &cancellables)
    }
    
}
