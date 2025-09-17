//
//  PlaceCourseUseCase.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

class PlaceCourseUseCase: PlaceCourseUseCaseProtocol {
    private let service: PlaceCourseServiceProtocol
    
    init(service: PlaceCourseServiceProtocol = PlaceCourseService()) {
        self.service = service
    }
    
    /// 장소 상세 화면
    func executeGetDetailPlace(path: PlaceCourseDetailPath) -> AnyPublisher<ResponseData<PlaceCourseDetailResponse>, Moya.MoyaError> {
        service.getDetailPlace(path: path)
    }
    
    /// 지역명 기반 장소
    func executeGetSearchPlace(query: PlaceCourseSearchQuery) -> AnyPublisher<ResponseData<PlaceCourseSearchResponse>, Moya.MoyaError> {
        service.getSearchPlace(query: query)
    }
    
    /// 좋아요 장소 무한 스크롤
    func executeGetLikeScroll(query: PlaceCourseLikeQuery) -> AnyPublisher<ResponseData<PlaceCourseLikeResponse>, Moya.MoyaError> {
        service.getLikeScroll(query: query)
    }
    
    /// 내 위치 기반 장소 검색
    func executeGetCurrentLocation(query: PlaceCourseCurrentSearchQuery) -> AnyPublisher<ResponseData<PlaceCourseSearchResponse>, Moya.MoyaError> {
        service.getCurrentLocation(query: query)
    }
}
