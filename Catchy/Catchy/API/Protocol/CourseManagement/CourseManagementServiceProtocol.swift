//
//  CourseManagementServiceProtocol.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [코스 관리] ServiceProtocol
protocol CourseManagementServiceProtocol {
    
    /// 코스 조회
    func getCourseList(courseRequest: CourseRequest) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError>
    
    /// 장소 검색 - 지역명 기반
    func getPlaceList(placeSearchRequest: PlaceSearchRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError>

    /// 장소 검색 - 상세 화면
    func getPlaceDetail(placeId: Int) -> AnyPublisher<ResponseData<PlaceDetailResponse>, MoyaError>
    
}
