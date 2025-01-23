//
//  CourseServiceProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation
import CombineMoya
import Combine
import Moya

protocol CouseServiceProtocol {
    // 코스 조회
    func getCourseInfo(courseData: GetCourseRequest) -> AnyPublisher<ResponseData<GetCourseInfo>, MoyaError>
}
