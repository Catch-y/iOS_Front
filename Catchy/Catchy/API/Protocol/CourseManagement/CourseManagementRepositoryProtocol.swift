//
//  CourseManagementRepositoryProtocol.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [코스 관리] RepositoryProtocol
protocol CourseManagementRepositoryProtocol {
    
    /// 코스 조회
    func getCourseListData(courseRequest: CourseRequest) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError>
    
    /// 장소 검색 - 지역명 기반
    func getPlaceListData(placeSearchReqeust: PlaceSearchRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError>
}

