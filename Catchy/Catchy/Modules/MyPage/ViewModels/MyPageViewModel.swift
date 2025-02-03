//
//  MyPageViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import SwiftUI
import Combine

class MyPageViewModel: ObservableObject {
    
    @Published var isEditingNickname: Bool = false  // 닉네임 수정 모달 상태 추가
    
    let container: DIContainer
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - MyPage View Properties
    
    /// 마이페이지 프로필 조회 response
    @Published var profileResponse: ProfileResponse?
    
    /// 마이페이지 프로필 조회 response 로딩 중?
    @Published var isLoading: Bool = false

    // MARK: - Init
    
    init(container: DIContainer) {
        self.container = container
    }
}

extension MyPageViewModel {
    
    // MARK: - API 호출 함수
    /// 마이페이지 프로필 조회
    func getProfile(){
        
        isLoading = true
        
        container.useCaseProvider.myPageUseCase
            .executeGetProfile()
            .tryMap{ responseData -> ResponseData<ProfileResponse> in
                if !responseData.isSuccess{
                    throw APIError
                        .serverError(
                            message: responseData.message,
                            code: responseData.code
                        )
                }
                
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                    
                switch completion {
                case .finished:
                    print("✅ Get Profile Server Completed")
                case .failure(let failure):
                    print("❌ Get Profile Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let response = response.result{
                    self.profileResponse = response
                }
                
            })
            .store(in: &cancellables)
            
    }
}

