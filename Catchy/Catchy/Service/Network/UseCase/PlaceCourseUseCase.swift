//
//  PlaceCourseUseCase.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [PlaceCourse] UseCase 객체
class PlaceCourseUseCase: PlaceCourseUseCaseProtocol {
    
    let repository: PlaceCourseRepositoryProtocol
    
    init(repository: PlaceCourseRepositoryProtocol = PlaceCourseRepository()) {
        self.repository = repository
    }
    
    /// 장소 상세 화면 API
    func executeGetPlaceDetail(placeId: Int) -> AnyPublisher<ResponseData<PlaceDetailResponse>, MoyaError> {
        return repository.getPlaceDetailData(placeId: placeId)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    /// 지역명 기반 장소 검색 API
    func executeGetPlaceListByRegion(placeSearchRequest: PlaceSearchByRegionRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError> {
        return repository.getPlaceListByRegionData(placeSearchRequest: placeSearchRequest)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    /// 좋아요한 장소 무한 스크롤 API
    func executeGetMyPlaceList(pageSize: Int, lastPlaceId: Int? = nil) -> AnyPublisher<ResponseData<MyPlaceResponse>, MoyaError> {
        return repository.getMyPlaceListData(pageSize: pageSize, lastPlaceId: lastPlaceId)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    /// 내 위치 기반 장소 검색 API
    func executeGetPlaceListByCurrent(placeSearchRequest: PlaceSearchByCurrentRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError> {
        return repository.getPlaceListByCurrentData(placeSearchRequest: placeSearchRequest)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
}
