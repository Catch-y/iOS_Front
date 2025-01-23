//
//  CouseRepository.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

class CouseRepository: CourseRepositoryProtocol {
    
    let service: CouseServiceProtocol
    
    init(service: CouseServiceProtocol = CouseService()) {
        self.service = service
    }
    
    func getCourseInfoData(courseData: GetCourseRequest) -> AnyPublisher<ResponseData<GetCourseInfo>, MoyaError> {
        return service.getCourseInfo(courseData: courseData)
    }
}
