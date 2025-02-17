//
//  NicknameEditViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import SwiftUI
import Combine

class NicknameEditViewModel: ObservableObject {
    
    /// 닉네임 입력 값
    @Published var nickname: String = ""
    
    /// 중복 확인 여부
    @Published var isDuplicateChecked: Bool = false
    
    
    
    private var cancellables = Set<AnyCancellable>()
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
}

extension NicknameEditViewModel {
    /// 닉네임 중복 체크
    public func checkNicknameAvailability() {
        container.useCaseProvider.memberUseCase.executePostNickname(nickname: nickname)
            .tryMap { respopnseData -> ResponseData<EmptyResponse> in
                if !respopnseData.isSuccess && respopnseData.code == "COMMON401" {
                    throw APIError.serverError(message: respopnseData.message, code: respopnseData.code)
                }
                
                print("User Nickname Check")
                return respopnseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("✅ User Nickname Check Completed")
                case .failure(let failure):
                    print("❌ User Nickname Fialed: \(failure)")
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                print("🔵 ResponseData: \(response)")
                if response.message == "이미 사용 중인 닉네임입니다." {
                    isDuplicateChecked = false
                } else if response.message == "사용가능한 닉네임입니다." {
                    isDuplicateChecked = true
                }
            })
            .store(in: &cancellables)
    }
    
    /// 닉네임 변경
    public func changeNickname(completion: @escaping (Bool) -> Void) {
        container.useCaseProvider.memberUseCase.executePatchNickname(nickname: nickname)
            .tryMap { responseData -> ResponseData<PatchNicknameResponse> in
                if !responseData.isSuccess {
                    throw APIError.serverError(message: responseData.message, code: responseData.code)
                }
                
                if let _ = responseData.result {
                    throw APIError.emptyResult
                }
                
                print("Patchy Nickname")
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("✅ User Nickname Patch Completed")
                case .failure(let failure):
                    print("❌ User Nickname Patch Fialed: \(failure)")
                }
            }, receiveValue: { response in
                if let response = response.result {
                    UserState.shared.setUserNickname(response.nickname)
                    completion(true)
                } else {
                    completion(false)
                }
            })
            .store(in: &cancellables)
    }
}
