//
//  SignUpViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import Foundation
import SwiftUI
import Combine

class SignUpViewModel: ObservableObject, ImageHandling {
    @Published var nickname: String = ""
    @Published var nicknameMessage: String = "이미 사용중인 닉네임입니다."
    @Published var nicknameAvail: Bool = false
    @Published var isLoading: Bool = false
    
    let container: DIContainer
    let appflowViewModel: AppFlowViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer, appFlowViewModel: AppFlowViewModel) {
        self.container = container
        self.appflowViewModel = appFlowViewModel
        setupNicknameValidation()
    }
    
    // MARK: - ImageProperty
    
    @Published var isImagePickerPresented: Bool = false
    @Published var selectedImageCount: Int = 0
    
    var profileImage: [UIImage] = []
    
    public func checkMainBtn() -> Bool {
        if profileImage.isEmpty {
            return false
        } else {
            if nicknameAvail {
                return true
            } else {
                return false
            }
        }
    }
    
    // MARK: - SignupFunc
    private func saveUserInfo(response: SocialLoginResponse, loginType: SocialLoginType) {
        let userInfo = UserInfo(accessToken: response.accessToken, refreshToken: response.refreshToken)
        let success = KeychainManager.standard.saveSession(userInfo, for: "catchyUser")
        print("회원 가입 후 로그인 성공: \(success)")
        
        UserState.shared.setLoginType(loginType)
        UserState.shared.setUserNickname(response.nickname)
        UserState.shared.setUserEmail(response.email)
    }
    
    private func setupNicknameValidation() {
        $nickname
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { !$0.isEmpty && $0.count <= 9}
            .sink(receiveValue: { [weak self] nickname in
                self?.checkNicknameAvailability(nickname: nickname)
            })
            .store(in: &cancellables)
    }
}

extension SignUpViewModel {
    func addImage(_ images: UIImage) {
        if !profileImage.isEmpty {
            profileImage.removeAll()
        }
        profileImage.append(images)
    }
    
    func getImages() -> [UIImage] {
        return profileImage
    }
    
    func removeImage(at index: Int) {
        profileImage.remove(at: index)
    }
    
    func showImagePicker() {
        self.isImagePickerPresented.toggle()
    }
}

extension SignUpViewModel {
    /// 회원 가입 API 함수
    /// - Parameter signUpNaviData: 로그인 후, 받아온 데이터 전달받아 회원가입 뷰에서 사용
    public func signupAction(signUpNaviData: SignUpNaviData) {
        
        isLoading = true
        
        container.useCaseProvider.authUseCase.executeSignup(socialSignup: signUpNaviData.loginType, signupRequest: .init(accessToken: signUpNaviData.accessToken, authorizationCode: signUpNaviData.authorizationCode, nickname: nickname), image: profileImage[0])
            .tryMap { responseData -> ResponseData<SocialLoginResponse> in
                if !responseData.isSuccess {
                    throw APIError.serverError(message: responseData.message, code: responseData.code)
                }
                
                guard let _ = responseData.result else {
                    throw APIError.emptyResult
                }
                print("✅ Signup of \(signUpNaviData.loginType): \(responseData)")
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                
                guard let self = self else { return }
                isLoading = false
                
                switch completion {
                case .finished:
                    print("✅ \(signUpNaviData.loginType) Signup Success")
                case .failure(let failure):
                    print("❌ \(signUpNaviData.loginType) Signup Failure: \(failure)")
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                print("🔵 ResponseData: \(response)")
                
                if let response = response.result {
                    saveUserInfo(response: response, loginType: signUpNaviData.loginType)
                    container.navigationRouter.pop()
                    appflowViewModel.onSignupSuccess()
                }
            })
            .store(in: &cancellables)
    }
    
    /// 닉네임 중복 체크 함수
    /// - Parameter nickname: 사용자가 입력한 닉네임
    private func checkNicknameAvailability(nickname: String) {
        container.useCaseProvider.memberUseCase.executePatchNickname(nickname: nickname)
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
                    nicknameAvail = false
                    nicknameMessage = response.message
                } else if response.message == "사용가능한 닉네임입니다." {
                    nicknameAvail = true
                    nicknameMessage = response.message
                }
                
            })
            .store(in: &cancellables)
    }
}
