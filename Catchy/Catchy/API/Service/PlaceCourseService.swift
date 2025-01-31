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
    
    /// 장소 검색 - 지역명 기반
    func getPlaceList(placeSearchRequest: PlaceSearchRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError> {
        return provider.requestPublisher(.getPlaceList(place: placeSearchRequest))
            .map(ResponseData<PlaceSearchResponse>.self)
            .eraseToAnyPublisher()
    }
}
