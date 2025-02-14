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
    /// [투표 카테고리] UseCase
    var voteUseCase : VoteUseCase {get set}
    /// [그룹생성] UseCase
    var groupUseCase : GroupUseCase { get set }
   
}

class UseCaseProvider: UseCaseProtocol {
    
    
    var authUseCase: AuthUseCase
    
    /// [코스 관리] UseCase
    var courseManagementUseCase: CourseManagementUseCase
    /// [그룹 관리 ] UseCase
    var groupUseCase : GroupUseCase
    
    /// [투표 관리] UseCase
    var voteUseCase : VoteUseCase
    init() {
        self.authUseCase = AuthUseCase()
        self.courseManagementUseCase = CourseManagementUseCase()
        self.groupUseCase = GroupUseCase()
        self.voteUseCase = VoteUseCase ()
    }
    
    
}
