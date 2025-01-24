//
//  CourseService.swift
//  Catchy
//
//  Created by LEE on 1/23/25.
//

import Foundation
import Moya
import Combine
import CombineMoya

class CourseService: CourseServiceProtocol {
    
    let provider: MoyaProvider<MypageAPITarget>
    
    init(provider: MoyaProvider<MypageAPITarget> = APIManager.shared.testProvider(for: MypageAPITarget.self)) {
        self.provider = provider
    }
    
    func getCourseInfo(courseData: GetCourseInfoRequest) -> AnyPublisher<ResponseData<GetCourseInfoResponse>, MoyaError> {
        
        return provider.requestPublisher(.getCourseInfo(courseData: courseData))
            .map(ResponseData<GetCourseInfoResponse>.self)
            .eraseToAnyPublisher()
    }
}
