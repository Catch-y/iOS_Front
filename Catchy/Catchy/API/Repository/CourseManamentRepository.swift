//
//  CourseManamentRepository.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [코스 관리] Repository 객체
class CourseManamentRepository: CourseManagementRepositoryProtocol {
    
    let provider: CourseManagementService
    
    init(provider: CourseManagementService = CourseManagementService()){
        self.provider = provider
    }
    
    /// 코스 조회
    func getCourseListData(courseRequest: CourseRequest) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError> {
        return provider.getCourseList(courseRequest: courseRequest)
    }
}
