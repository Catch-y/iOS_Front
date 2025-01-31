//
//  CourseUseCase.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [Course] UseCase 객체
class CourseUseCase: CourseUseCaseProtocol {
    
    let repository: CourseRepositoryProtocol
    
    init(repository: CourseRepositoryProtocol = CourseRepository()) {
        self.repository = repository
    }
    
    /// 코스 조회
    func executeGetCourseList(courseRequest: CourseRequest) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError> {
        
        return repository.getCourseListData(courseRequest: courseRequest)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    /// 장소 검색 - 지역명 기반
    func executeGetPlaceList(placeSearchRequest: PlaceSearchRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError> {
        return repository.getPlaceListData(placeSearchRequest: placeSearchRequest)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    /// 장소 검색 - 상세 화면
    func executeGetPlaceDetail(placeId: Int) -> AnyPublisher<ResponseData<PlaceDetailResponse>, MoyaError> {
        return repository.getPlaceDetailData(placeId: placeId)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
}

