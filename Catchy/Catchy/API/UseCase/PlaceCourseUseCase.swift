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
    
    /// 장소 상세 화면 API
    func executeGetPlaceDetail(placeId: Int) -> AnyPublisher<ResponseData<PlaceDetailResponse>, MoyaError> {
        return repository.getPlaceDetailData(placeId: placeId)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
}
