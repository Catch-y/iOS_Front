//
//  PlaceCourseServiceProtocol.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [PlaceCourse] ServiceProtocol
protocol PlaceCourseServiceProtocol {
    
    /// 장소 상세 화면 API
    func getPlaceDetail(placeId: Int) -> AnyPublisher<ResponseData<PlaceDetailResponse>, MoyaError>
    
    /// 지역명 기반 장소 검색 API
    func getPlaceListByRegion(placeSearchRequest: PlaceSearchByRegionRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError>
    
    /// 좋아요한 장소 무한 스크롤 API
    func getMyPlaceList(pageSize: Int, lastPlaceId: Int) -> AnyPublisher<ResponseData<MyPlaceResponse>, MoyaError>
    
    /// 내 위치 기반 장소 검색 API
    func getPlaceListByCurrent(placeSearchRequest: PlaceSearchByCurrentRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError>
}
