//
//  SettingViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 2/5/25.
//

import SwiftUI
import Combine

class SettingViewModel: ObservableObject {
    
    let container: DIContainer
    let appFlowViewModel: AppFlowViewModel
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(container: DIContainer, appFlowViewModel: AppFlowViewModel) {
        self.container = container
        self.appFlowViewModel = appFlowViewModel
    }
    
    public func logout() {
        UserState.shared.clearProfile()
        KeychainManager.standard.deleteSession(for: "catchyUser")
        appFlowViewModel.appState = .login
        container.navigationRouter.popToRootView()
    }
    
    public func deleteUser() {
        print("회원탈퇴")
    }
}
