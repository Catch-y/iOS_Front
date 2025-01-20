//
//  AppleLoginManager.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import Foundation
import AuthenticationServices

class AppleLoginManager: NSObject {
    var onAuthorizationCompleted: ((String, String, String?) -> Void)?
    
    public func signWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}

extension AppleLoginManager: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            DispatchQueue.main.async {
                let fullName = appleIDCredential.fullName.flatMap { nameComponents in
                    [nameComponents.familyName, nameComponents.givenName]
                        .compactMap { $0 }
                        .joined(separator: "")
                }
                
                
                let appleUserData = AppleUserData(
                    userIdentifier: appleIDCredential.user,
                    fullName: fullName ?? "사용자 이름 없음",
                    email: appleIDCredential.email ?? "이메일 정보 없음",
                    authorizationCode: String(data: appleIDCredential.authorizationCode ?? Data(), encoding: .utf8),
                    identityToken: String(data: appleIDCredential.identityToken ?? Data(), encoding: .utf8)
                )
                
                if let identityToken = appleUserData.identityToken,
                   let authorizationCode = appleUserData.authorizationCode {
                    self.onAuthorizationCompleted?(identityToken, authorizationCode, appleIDCredential.email ?? "유저 이메일 정보 없음")
                    print("유저 인가 코드: \(identityToken)")
                    print("유저 authorization코드: \(authorizationCode)")
                    print("유저 이메일: \(appleIDCredential.email ?? "")")
                }
            }
        }
    }
}
