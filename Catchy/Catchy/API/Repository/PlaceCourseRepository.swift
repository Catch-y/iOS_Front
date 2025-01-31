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

    /// 장소 검색 - 지역명 기반
    func getPlaceListData(placeSearchRequest: PlaceSearchRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError> {
        return provider.getPlaceList(placeSearchRequest: placeSearchRequest)
    }
}
