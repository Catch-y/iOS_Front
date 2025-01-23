//
//  CouseService.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation
import Moya
import Combine
import CombineMoya

class CouseService: CouseServiceProtocol {
    
    let provider: MoyaProvider<CourseAPITarget>
    
    init(provider: MoyaProvider<CourseAPITarget> = APIManager.shared.testProvider(for: CourseAPITarget.self)) {
        self.provider = provider
    }
    
    func getCourseInfo(courseData: GetCourseRequest) -> AnyPublisher<ResponseData<GetCourseInfo>, MoyaError> {
        return provider.requestPublisher(.getCourseInfo(courseData: courseData))
            .map(ResponseData<GetCourseInfo>.self)
            .eraseToAnyPublisher()
    }
}
