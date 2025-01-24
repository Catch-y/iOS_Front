//
//
//  CourseServiceProtocol.swift
//  Catchy
//
//  Created by LEE on 1/23/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// 유저가 실행하는 함수. 
protocol CourseUseCaseProtocol {
    func executeGetCourseInfo(courseData: GetCourseInfoRequest) ->
    AnyPublisher<ResponseData<GetCourseInfoResponse>, MoyaError>
}
