//
//  CouseUseCase.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

class CouseUseCase: CourseUseCaseProtocol {
    
    let repository: CourseRepositoryProtocol
    
    init(repository: CourseRepositoryProtocol = CouseRepository()) {
        self.repository = repository
    }
    
    func executeGetCourseInfo(courseData: GetCourseRequest) -> AnyPublisher<ResponseData<GetCourseInfo>, MoyaError> {
        return repository.getCourseInfoData(courseData: courseData)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
}
