//
//  UseCaseProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 1/13/25.
//

import Foundation

protocol UseCaseProtocol {
    var authUseCase: AuthUseCase { get set }
    
    /// [코스 관리] UseCase
    var courseManagementUseCase: CourseManagementUseCase { get set }
}

class UseCaseProvider: UseCaseProtocol {
    var authUseCase: AuthUseCase
    
    /// [코스 관리] UseCase
    var courseManagementUseCase: CourseManagementUseCase
    
    
    ///[투표 멤버 관리] UseCase
    var votingMemberUseCase: VotingMemberUseCase

    
    init() {
        self.authUseCase = AuthUseCase()
        self.courseManagementUseCase = CourseManagementUseCase()
        self.votingMemberUseCase = VotingMemberUseCase()
    }
    
    
}
