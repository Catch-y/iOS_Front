//
//  UseCaseProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 1/13/25.
//

import Foundation

protocol UseCaseProtocol {
    var authUseCase: AuthUseCase { get set }
    
    /// [Course] UseCase
    var courseUseCase: CourseUseCase { get set }
    
    /// [PlaceCourse] UseCase
    var placeCourseUseCase: PlaceCourseUseCase { get set }
}

class UseCaseProvider: UseCaseProtocol {
    var authUseCase: AuthUseCase
    
    /// [코스 관리] UseCase
    var courseUseCase: CourseUseCase
    
    var placeCourseUseCase: PlaceCourseUseCase
    
    init() {
        self.authUseCase = AuthUseCase()
        self.courseUseCase = CourseUseCase()
        self.placeCourseUseCase = PlaceCourseUseCase()
    }
}
