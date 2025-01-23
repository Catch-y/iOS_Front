//
//  UseCaseProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 1/13/25.
//

import Foundation

protocol UseCaseProtocol {
    var authUseCase: AuthUseCase { get set }
    var couseUseCase: CouseUseCase { get set }
}

class UseCaseProvider: UseCaseProtocol {
    var authUseCase: AuthUseCase
    var couseUseCase: CouseUseCase
    
    init() {
        self.authUseCase = AuthUseCase()
        self.couseUseCase = CouseUseCase()
    }
}
