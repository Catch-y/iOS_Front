//
//  PlaceCourseRepository.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [PlaceCourse] Repository 객체
class PlaceCourseRepository: PlaceCourseRepositoryProtocol {
    
    let provider: PlaceCourseServiceProtocol
    
    init(provider: PlaceCourseServiceProtocol = PlaceCourseService()) {
        self.provider = provider
    }

    /// 코스 상세 화면 API
    func getPlaceDetailData(placeId: Int) -> AnyPublisher<ResponseData<PlaceDetailResponse>, MoyaError> {
        return provider.getPlaceDetail(placeId: placeId)
    }
    
    /// 지역명 기반 장소 검색 API
    func getPlaceListByRegionData(placeSearchRequest: PlaceSearchByRegionRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError> {
        return provider.getPlaceListByRegion(placeSearchRequest: placeSearchRequest)
    }
    
    /// 좋아요한 장소 무한 스크롤 API
    func getMyPlaceListData(pageSize: Int, lastPlaceId: Int? = nil) -> AnyPublisher<ResponseData<MyPlaceResponse>, MoyaError> {
        return provider.getMyPlaceList(pageSize: pageSize, lastPlaceId: lastPlaceId)
    }
    
    /// 내 위치 기반 장소 검색 API
    func getPlaceListByCurrentData(placeSearchRequest: PlaceSearchByCurrentRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError> {
        return provider.getPlaceListByCurrent(placeSearchRequest: placeSearchRequest)
    }
}
