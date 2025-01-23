//
//  CourseServiceProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

protocol CourseUseCaseProtocol {
    func executeGetCourseInfo(courseData: GetCourseRequest) -> AnyPublisher<ResponseData<GetCourseInfo>, MoyaError>
}
