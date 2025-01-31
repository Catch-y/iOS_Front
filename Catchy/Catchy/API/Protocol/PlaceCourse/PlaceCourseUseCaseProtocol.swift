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
    
    /// 장소 검색 - 지역명 기반
    func executeGetPlaceList(placeSearchRequest: PlaceSearchRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError>
    
}
