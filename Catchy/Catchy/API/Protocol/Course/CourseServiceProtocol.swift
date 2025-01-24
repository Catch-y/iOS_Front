//
//  CourseServiceProtocol.swift
//  Catchy
//
//  Created by LEE on 1/23/25.
//

import Foundation
import CombineMoya
import Combine
import Moya

/// 서비스는 CourseAPITartget을 관리

protocol CourseServiceProtocol {
    
    // 코스 조회
    func getCourseInfo(courseData: GetCourseInfoRequest) ->
    AnyPublisher<ResponseData<GetCourseInfoResponse>, MoyaError>
}
