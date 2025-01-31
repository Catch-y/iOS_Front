//
//  PlaceCourseUseCaseProtocol.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [PlaceCourse] UseCaseProtocol
protocol PlaceCourseUseCaseProtocol {
    
    /// 장소 상세 화면 API
    func executeGetPlaceDetail(placeId: Int) -> AnyPublisher<ResponseData<PlaceDetailResponse>, MoyaError>
    
    /// 지역명 기반 장소 검색 API
    func executeGetPlaceListByRegion(placeSearchRequest: PlaceSearchByRegionRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError>
    
    /// 좋아요한 장소 무한 스크롤 API
    func executeGetMyPlaceList(pageSize: Int, lastPlaceId: Int) -> AnyPublisher<ResponseData<MyPlaceResponse>, MoyaError>
    
    /// 내 위치 기반 장소 검색 API
    func executeGetPlaceListByCurrent(placeSearchRequest: PlaceSearchByCurrentRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError>
}
