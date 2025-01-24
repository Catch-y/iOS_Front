//
//  CourseRepository.swift
//  Catchy
//
//  Created by LEE on 1/23/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// 레포지터리는 서비스를 쓴다.
class CourseRepository: CourseRepositoryProtocol {
    let service: CourseServiceProtocol
    
    init(service: CourseServiceProtocol = CourseService()) {
        self.service = service
    }
    
    func getCourseInfoData(courseData: GetCourseInfoRequest) -> AnyPublisher<ResponseData<GetCourseInfoResponse>, MoyaError> {
        
        return service.getCourseInfo(courseData: courseData)
    }
}

