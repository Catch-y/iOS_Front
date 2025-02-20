//
//  FCMTokenAPI.swift
//  Catchy
//
//  Created by 정의찬 on 2/20/25.
//

import Foundation
import Combine

class FCMTokenAPI {
    let container: DIContainer = .init()
    static let shared = FCMTokenAPI()
    
    var cancellables = Set<AnyCancellable>()
    
    func sendUpdatedFcmTokenToServer(_ token: String ) {
        container.useCaseProvider.memberUseCase.executePatchFCMToken(token: UserState.shared.getFcmToken())
            .tryMap { respopnseData -> ResponseData<EmptyResult> in
                
                if !respopnseData.isSuccess {
                    throw APIError.serverError(message: respopnseData.message, code: respopnseData.code)
                }
                
                print("FMCToken Check")
                return respopnseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("✅ patchFCMToken Completed")
                case .failure(let failure):
                    print("❌ patchFCMToken Fialed: \(failure)")
                }
            }, receiveValue: { result in
                print("FCMTOKEN: \(result.message)")
                
            })
            .store(in: &cancellables)
    }
}
