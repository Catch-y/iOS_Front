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
    
    /// [Course] UseCase
    var courseUseCase: CourseUseCase
    
    /// [PlaceCourse] UseCase
    var placeCourseUseCase: PlaceCourseUseCase
    
    init() {
        self.authUseCase = AuthUseCase()
        self.courseUseCase = CourseUseCase()
        self.placeCourseUseCase = PlaceCourseUseCase()
    }
}
