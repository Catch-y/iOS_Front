//
//  LoginViewModel.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import Foundation
import Combine

@Observable
class LoginViewModel {
    
    // MARK: - Dependency
    let container: DIContainer
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: - Init
    init(container: DIContainer) {
        self.container = container
    }
}
