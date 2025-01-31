//
//  PlaceCourseUseCase.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [PlaceCourse] UseCase 객체
class PlaceCourseUseCase: PlaceCourseUseCaseProtocol {
    
    let repository: PlaceCourseRepositoryProtocol
    
    init(repository: PlaceCourseRepositoryProtocol = PlaceCourseRepository()) {
        self.repository = repository
    }
    
    /// 장소 검색 - 지역명 기반
    func executeGetPlaceList(placeSearchRequest: PlaceSearchRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError> {
        return repository.getPlaceListData(placeSearchRequest: placeSearchRequest)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
}
