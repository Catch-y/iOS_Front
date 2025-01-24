//
//  UseCaseProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 1/13/25.
//

import Foundation

protocol UseCaseProtocol {
    var authUseCase: AuthUseCase { get set }
    var courseUseCase: CourseUseCase { get set }
}

class UseCaseProvider: UseCaseProtocol {
    var authUseCase: AuthUseCase
    var courseUseCase: CourseUseCase
    
    init() {
        self.authUseCase = AuthUseCase()
        self.courseUseCase = CourseUseCase()
    }
}
