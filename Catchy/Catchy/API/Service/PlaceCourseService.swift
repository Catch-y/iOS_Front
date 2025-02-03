//
//  PlaceCourseService.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [PlaceCourse] Service 객체
class PlaceCourseService: PlaceCourseServiceProtocol {
    
    let provider: MoyaProvider<PlaceCourseAPITarget>
    
    init(provider: MoyaProvider<PlaceCourseAPITarget> = APIManager.shared.testProvider(for: PlaceCourseAPITarget.self)) {
        self.provider = provider
    }
    
    
    /// 장소 상세 화면 API
    func getPlaceDetail(placeId: Int) -> AnyPublisher<ResponseData<PlaceDetailResponse>, MoyaError> {
        return provider.requestPublisher(.getPlaceDetail(placeId: placeId))
            .map(ResponseData<PlaceDetailResponse>.self)
            .eraseToAnyPublisher()
    }
 
    /// 지역명 기반 장소 검색 API
    func getPlaceListByRegion(placeSearchRequest: PlaceSearchByRegionRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError> {
        return provider.requestPublisher(.getPlaceSearchByRegion(place: placeSearchRequest))
            .map(ResponseData<PlaceSearchResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 좋아요한 장소 무한 스크롤 APi
    func getMyPlaceList(pageSize: Int, lastPlaceId: Int) -> AnyPublisher<ResponseData<MyPlaceResponse>, MoyaError> {
        return provider.requestPublisher(.getMyPlace(pageSize: pageSize, lastPlaceId: lastPlaceId))
            .map(ResponseData<MyPlaceResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 내 위치 기반 장소 검색 API
    func getPlaceListByCurrent(placeSearchRequest: PlaceSearchByCurrentRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError> {
        return provider.requestPublisher(.getPlaceSearchByCurrent(place: placeSearchRequest))
            .map(ResponseData<PlaceSearchResponse>.self)
            .eraseToAnyPublisher()
    }
}
