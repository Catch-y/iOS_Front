//
//  CourseManagementUseCase.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [코스 관리] UseCase 객체
class CourseManagementUseCase: CourseManagementUseCaseProtocol {
    
    let repository: CourseManagementRepositoryProtocol
    
    init(repository: CourseManagementRepositoryProtocol = CourseManamentRepository()) {
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
    func executeGetPlaceDetail(placeDetailRequest: PlaceDetailRequest) -> AnyPublisher<ResponseData<PlaceDetailResponse>, MoyaError> {
        return repository.getPlaceDetailData(placeDetailRequest: placeDetailRequest)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
}

