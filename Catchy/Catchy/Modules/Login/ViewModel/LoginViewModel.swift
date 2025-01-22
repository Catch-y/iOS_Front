//
//  LoginViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation

class LoginViewModel: ObservableObject {
    let container: DIContainer
    let appflowViewModel: AppFlowViewModel
    
    init(container: DIContainer, appflowViewModel: AppFlowViewModel) {
        self.container = container
        self.appflowViewModel = appflowViewModel
    }
}
