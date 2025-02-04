//
//  LoginViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var isLogin: Bool = false
    @Published var isLoading: Bool = false
    
    let container: DIContainer
    let appflowViewModel: AppFlowViewModel
    private var cancellables = Set<AnyCancellable>()
    
    let appleLoginManager = AppleLoginManager()
    let kakaoLoginManager = KakaoLoginManager()
    
    init(container: DIContainer, appflowViewModel: AppFlowViewModel) {
        self.container = container
        self.appflowViewModel = appflowViewModel
        self.appleLoginManager.onAuthorizationCompleted = { [weak self] identityToken, authorization, email in
            guard let self = self else { return }
            
            if let email = email {
                self.appleLoginAPI(appleUserInfo: .init(identityToken: identityToken, authorizationCode: authorization, email: email))
            }
        }
    }
    
    // MARK: - SocailLogin
    public func kakaoLogin() {
        kakaoLoginManager.fectchAccessToken { [weak self] result in
            switch result {
            case .success(let auth):
                self?.kakaoLoginManager.getUserEmail { [weak self] result in
                    switch result {
                    case .success(let email):
                        self?.kakaoLoginAPI(kakaoUserInfo: .init(accessToken: auth, email: email))
                    case .failure(let error):
                        print("카카오 이메일 받아오기 실패: \(error)")
                    }
                }
            case .failure(let error):
                print("카카오 토큰을 받아오기 실패: \(error)")
            }
        }
    }
    
    public func appleLogin() {
        appleLoginManager.signWithApple()
    }
    
    private func handleSignUpFlow(signUpNaviData: SignUpNaviData) {
        self.isLogin = false
        self.goToSignUpPage(signUpNaviData: signUpNaviData)
        
    }
    
    private func goToSignUpPage(signUpNaviData: SignUpNaviData) {
        container.navigationRouter.push(to: .SignUpView(signUpNaviData: signUpNaviData))
    }
    
    private func saveKeychain(socialLoginResponse: SocialLoginResponse) {
        let userInfo = UserInfo(accessToken: socialLoginResponse.accessToken, refreshToken: socialLoginResponse.refreshToken)
        let checkChain = KeychainManager.standard.saveSession(userInfo, for: "catchyUser")
        print("키체인 저장 성공: \(checkChain)")
        print("저장된 키체인 정보: \(String(describing: KeychainManager.standard.loadSession(for: "catchyUser")))")
    }
}

extension LoginViewModel {
    private func kakaoLoginAPI(kakaoUserInfo: KakaoUserInfo) {
        isLoading = true
        container.useCaseProvider.authUseCase.executeSocialLogin(socialLoginType: .kakao, socialToken: kakaoUserInfo.accessToken)
            .tryMap { responseData -> ResponseData<SocialLoginResponse> in
                if responseData.code == "SOCIAL404" {
                    self.handleSignUpFlow(signUpNaviData: .init(accessToken: kakaoUserInfo.accessToken, authorizationCode: nil, email: kakaoUserInfo.email, loginType: .kakao))
                    throw APIError.serverError(message: responseData.message, code: responseData.code)
                }
                
                guard let _ = responseData.result else {
                    throw APIError.emptyResult
                }
                print("✅ Kakao LoginServer: \(responseData)")
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
                switch completion {
                case .finished:
                    print("✅ kakaoLogin Completed")
                case .failure(let failure):
                    print("❌ KakaoLogin Login Failed: \(failure)")
                    isLogin = false
                }
                
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                isLogin = true
                
                if let response = response.result {
                    saveKeychain(socialLoginResponse: response)
                    UserState.shared.setLoginType(.kakao)
                    appflowViewModel.onLoginSuccess(loginViewModel: self)
                }
            })
            .store(in: &cancellables)
    }
    
    /// 애플 로그인 시도 API
    /// - Parameter appleUserInfo: 애플 로그인 후 회원가입 시 필요한 데이터
    private func appleLoginAPI(appleUserInfo: AppleUserInfo) {
        isLoading = true
        container.useCaseProvider.authUseCase.executeSocialLogin(socialLoginType: .apple, socialToken: appleUserInfo.identityToken)
            .tryMap { responseData -> ResponseData<SocialLoginResponse> in
                if responseData.code == "SOCIAL404" {
                    self.handleSignUpFlow(signUpNaviData: .init(accessToken: appleUserInfo.identityToken, authorizationCode: appleUserInfo.authorizationCode, email: appleUserInfo.email, loginType: .apple))
                    throw APIError.serverError(message: responseData.message, code: responseData.code)
                }
                
                guard let _ = responseData.result else {
                    throw APIError.emptyResult
                }
                print("Appple LoginServer: \(responseData)")
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
                switch completion {
                case .finished:
                    print("✅ Apple Login Server Completed")
                case .failure(let failure):
                    print("❌ Apple Login Failed: \(failure)")
                    isLogin = false
                }
                
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                print("🔵 ResponseData: \(response)")
                isLogin = true
                
                if let response = response.result {
                    saveKeychain(socialLoginResponse: response)
                    UserState.shared.setLoginType(.apple)
                    appflowViewModel.onLoginSuccess(loginViewModel: self)
                }
            })
            .store(in: &cancellables)
    }
}
