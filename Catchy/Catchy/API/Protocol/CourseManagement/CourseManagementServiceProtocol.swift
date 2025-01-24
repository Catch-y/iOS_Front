//
//  CourseManagementServiceProtocol.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [코스관리] ServiceProtocl
protocol CourseManagementServiceProtocol {
    
    /// 코스 조회
    func getCourseList(courseRequest: CourseRequest) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError>
}
