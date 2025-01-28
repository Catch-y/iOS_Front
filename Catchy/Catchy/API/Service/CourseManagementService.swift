//
//  CourseManagementService.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [코스 관리] Service 객체
class CourseManagementService: CourseManagementServiceProtocol {
    
    let provider: MoyaProvider<CourseManagementAPITarget>
    
    init(provider: MoyaProvider<CourseManagementAPITarget> = APIManager.shared.testProvider(for: CourseManagementAPITarget.self)){
        self.provider = provider
    }
    
    /// 코스 조회
    func getCourseList(courseRequest: CourseRequest) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError> {
        return provider.requestPublisher(.getCourseList(course: courseRequest))
            .map(ResponseData<CourseResponse>.self)
            .eraseToAnyPublisher()
            
    }
    
    /// 장소 검색 - 지역명 기반
    func getPlaceList(placeSearchRequest: PlaceSearchRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError> {
        return provider.requestPublisher(.getPlaceList(place: placeSearchRequest))
            .map(ResponseData<PlaceSearchResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 장소 검색 - 상세 화면
    func getPlaceDetail(placeDetailRequest: PlaceDetailRequest) -> AnyPublisher<ResponseData<PlaceDetailResponse>, MoyaError> {
        return provider.requestPublisher(.getPlaceDetail(place: placeDetailRequest))
            .map(ResponseData<PlaceDetailResponse>.self)
            .eraseToAnyPublisher()
    }
}
