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

// 데이터를 전달
protocol CourseRepositoryProtocol {
    
    func getCourseInfoData(courseData: GetCourseInfoRequest) ->
    AnyPublisher<ResponseData<GetCourseInfoResponse>, MoyaError>
}
