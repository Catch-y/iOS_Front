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

protocol CourseRepositoryProtocol {
    func getCourseInfoData(courseData: GetCourseRequest) -> AnyPublisher<ResponseData<GetCourseInfo>, MoyaError>
}
