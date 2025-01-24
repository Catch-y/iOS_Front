//
//  CourseUseCase.swift
//  Catchy
//
//  Created by LEE on 1/23/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

class CourseUseCase: CourseUseCaseProtocol {
    
    let repository: CourseRepositoryProtocol
    
    init(repository: CourseRepositoryProtocol = CourseRepository()) {
        self.repository = repository
    }
    
    func executeGetCourseInfo(courseData: GetCourseInfoRequest) -> AnyPublisher<ResponseData<GetCourseInfoResponse>, MoyaError> {
        
        return repository.getCourseInfoData(courseData: courseData)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
}
