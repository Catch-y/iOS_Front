//
//  CourseManagementService.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [코스 관리] Service 객체
class CourseManagementService: CourseManagementServiceProtocol {
    
    let provider: MoyaProvider<CourseManagementAPITarget>
    
    init(provider: MoyaProvider<CourseManagementAPITarget> = APIManager.shared.testProvider(for: CourseManagementAPITarget.self)){
        self.provider = provider
    }
    
    /// 코스 조회
    func getCourseList(courseRequest: CourseRequest) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError> {
        return provider.requestPublisher(.getCourseList(course: courseRequest))
            .map(ResponseData<CourseResponse>.self)
            .eraseToAnyPublisher()
            
    }
}
