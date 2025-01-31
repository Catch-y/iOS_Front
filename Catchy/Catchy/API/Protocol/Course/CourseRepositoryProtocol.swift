//
//  CourseProtocol.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [Course] RepositoryProtocol
protocol CourseRepositoryProtocol {
    
    /// 코스 조회
    func getCourseListData(courseRequest: CourseRequest) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError>
    
    /// 장소 검색 - 지역명 기반
    func getPlaceListData(placeSearchRequest: PlaceSearchRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError>
    
    /// 장소 검색 - 상세 화면
    func getPlaceDetailData(placeId: Int) -> AnyPublisher<ResponseData<PlaceDetailResponse>, MoyaError>
}

