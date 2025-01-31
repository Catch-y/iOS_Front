//
//  CourseService.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [Course] Service 객체
class CourseService: CourseServiceProtocol {
    
    let provider: MoyaProvider<CourseAPITarget>
    
    init(provider: MoyaProvider<CourseAPITarget> = APIManager.shared.testProvider(for: CourseAPITarget.self)){
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
    func getPlaceDetail(placeId: Int) -> AnyPublisher<ResponseData<PlaceDetailResponse>, MoyaError> {
        return provider.requestPublisher(.getPlaceDetail(placeId: placeId))
            .map(ResponseData<PlaceDetailResponse>.self)
            .eraseToAnyPublisher()
    }
}
