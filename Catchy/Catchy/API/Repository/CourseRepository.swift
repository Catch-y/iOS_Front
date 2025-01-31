//
//  CourseRepository.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [Course] Repository 객체
class CourseRepository: CourseRepositoryProtocol {
    
    let provider: CourseServiceProtocol
    
    init(provider: CourseServiceProtocol = CourseService()){
        self.provider = provider
    }
    
    /// 코스 조회
    func getCourseListData(courseRequest: CourseRequest) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError> {
        return provider.getCourseList(courseRequest: courseRequest)
    }
    
    /// 장소 검색 - 지역명 기반
    func getPlaceListData(placeSearchRequest: PlaceSearchRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError> {
        return provider.getPlaceList(placeSearchRequest: placeSearchRequest)
    }
    
    /// 장소 검색 - 상세 화면
    func getPlaceDetailData(placeId: Int) -> AnyPublisher<ResponseData<PlaceDetailResponse>, MoyaError> {
        return provider.getPlaceDetail(placeId: placeId)
    }
}
